import prestashop from 'prestashop';
import useCheckoutStepsController from '../../components/useCheckoutStepsController';

/**
 * Edit delivery step handler
 * @param event {object} - click event
 */
const editDeliveryStepHandler = (event) => {
  event.preventDefault();
  event.stopPropagation();
  const { changeStep } = useCheckoutStepsController();
  const deliveryStep = document.querySelector('#checkout-delivery-step');

  changeStep(deliveryStep);
  prestashop.emit('editDelivery');
};

export default editDeliveryStepHandler;