<?php

namespace Emartech\Emarsys\Model\Data;

use Emartech\Emarsys\Api\Data\CustomersApiResponseInterface;

class CustomersApiResponse extends ListApiResponseBase implements CustomersApiResponseInterface
{
    /**
     * @return \Emartech\Emarsys\Api\Data\CustomerInterface[]
     */
    public function getCustomers()
    {
        return $this->getData(self::CUSTOMERS_KEY);
    }

    /**
     * @param \Emartech\Emarsys\Api\Data\CustomerInterface[] $customers
     *
     * @return $this
     */
    public function setCustomers(array $customers)
    {
        $this->setData(self::CUSTOMERS_KEY, $customers);
        return $this;
    }
}
