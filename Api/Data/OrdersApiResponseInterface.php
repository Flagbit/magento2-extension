<?php

namespace Emartech\Emarsys\Api\Data;

interface OrdersApiResponseInterface extends ListApiResponseBaseInterface
{
    const ITEMS_KEY = 'items';

    /**
     * @return \Emartech\Emarsys\Api\Data\OrderInterface[]
     */
    public function getItems();

    /**
     * @param \Emartech\Emarsys\Api\Data\OrderInterface[] $items
     *
     * @return $this
     */
    public function setItems(array $items);
}
