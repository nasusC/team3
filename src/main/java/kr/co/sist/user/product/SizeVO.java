package kr.co.sist.user.product;

/**
 * @author : S.H.CHA
 */
public class SizeVO {
    private int chooseSizeId, size;
    private int productId;

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getChooseSizeId() {
        return chooseSizeId;
    }

    public void setChooseSizeId(int chooseSizeId) {
        this.chooseSizeId = chooseSizeId;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
