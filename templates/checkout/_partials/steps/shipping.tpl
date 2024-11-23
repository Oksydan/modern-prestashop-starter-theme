{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  <div id="hook-display-before-carrier">
    {$hookDisplayBeforeCarrier nofilter}
  </div>

  <div class="delivery-options-list">
    {if $delivery_options|count}
      <form
        class="clearfix"
        id="js-delivery"
        data-url-update="{url entity='order' params=['ajax' => 1, 'action' => 'selectDeliveryOption']}"
        method="post"
      >
        <div class="form-fields">
          {block name='delivery_options'}
            <div class="delivery-options">
                {foreach from=$delivery_options item=carrier key=carrier_id}
                  <div class="mb-3 checkout-option-block checkout-option delivery-option js-delivery-option {if $delivery_option == $carrier_id} selected{/if}">
                    <input class="custom-control-input" type="radio" name="delivery_option[{$id_address}]" id="delivery_option_{$carrier.id}" value="{$carrier_id}"{if $delivery_option == $carrier_id} checked{/if}>

                    <label class="card mb-0 cursor-pointer h-100" for="delivery_option_{$carrier.id}">
                      <div class="card-body checkout-option__body py-sm-3 px-sm-4 p-2">
                        <div class="checkout-option__row row align-items-center">
                          <div class="col-auto checkout-option__col checkout-option__col--thumb">
                            <div class="checkout-option__thumb">
                              {if $carrier.logo}
                                <img src="{$carrier.logo}" alt="{$carrier.name}" class="checkout-option__img img-fluid" />
                              {else}
                                <img src="{$urls.img_url}checkout/carrier_default.svg" class="checkout-option__img img-fluid" />
                              {/if}
                            </div>
                          </div>
                          <div class="col checkout-option__col">
                            <div class="checkout-option__row checkout-option__row--inner row align-items-center">
                              <div class="col checkout-option__col checkout-option__col--text">
                                <p class="h5 mb-0">
                                  {$carrier.name}
                                </p>
                                <span class="checkout-option__delay text-muted font-sm">{$carrier.delay}</span>

                              </div>
                              <div class="col-sm-auto col-12 checkout-option__col checkout-option__col--price mt-sm-0 mt-1">
                                <div class="checkout-option__price price text-end">
                                  {$carrier.price}
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </label>

                  </div>
                  <div class="carrier-extra-content js-carrier-extra-content my-3 {if $delivery_option != $carrier_id}d-none{/if}">{$carrier.extraContent nofilter}</div>
                {/foreach}
              </div>
          {/block}
          <div class="order-options">
            <div id="delivery">
              <label for="delivery_message">{l s='If you would like to add a comment about your order, please write it in the field below.' d='Shop.Theme.Checkout'}</label>
              <textarea class="form-control" rows="4" cols="120" id="delivery_message" name="delivery_message">{$delivery_message}</textarea>
            </div>

            {if $recyclablePackAllowed}
              <div class="mb-3 my-3">
                <div class="form-check">
                  <input
                    class="form-check-input"
                    id="input_recyclable"
                    name="recyclable"
                    type="checkbox"
                    value="1"
                    {if $recyclable}
                      checked
                    {/if}
                  >
                  <label class="form-check-label"
                         for="input_recyclable">
                      {l s='I would like to receive my order in recycled packaging.' d='Shop.Theme.Checkout'}
                  </label>
                </div>
              </div>
            {/if}

            {if $gift.allowed}
              <div class="mb-3 my-3">
                <div class="form-check">
                  <input
                    class="form-check-input js-gift-checkbox"
                    id="input_gift"
                    name="gift"
                    type="checkbox"
                    value="1"
                    {if $gift.isGift}
                      checked
                    {/if}
                  >
                  <label class="form-check-label"
                         for="input_gift">
                      {$gift.label}
                  </label>
                </div>
              </div>

              <div id="gift" class="collapse{if $gift.isGift} in{/if}">
                <label for="gift_message">{l s='If you\'d like, you can add a note to the gift:' d='Shop.Theme.Checkout'}</label>
                <textarea  class="form-control" rows="4" cols="120" id="gift_message" name="gift_message">{$gift.message}</textarea>
              </div>
            {/if}

          </div>
        </div>
        <div class="text-end mt-3">
          <button type="submit" class="continue btn btn-primary d-none d-md-inline-block" name="confirmDeliveryOption" value="1">
            {l s='Continue' d='Shop.Theme.Actions'}
          </button>
          <button type="submit" class="continue btn btn-primary text-center w-100 d-block d-md-none" name="confirmDeliveryOption" value="1">
            {l s='Continue' d='Shop.Theme.Actions'}
          </button>
        </div>
      </form>
    {else}
      <p class="alert alert-danger">{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>

  <div id="hook-display-after-carrier">
    {$hookDisplayAfterCarrier nofilter}
  </div>

  <div id="extra_carrier"></div>
{/block}
