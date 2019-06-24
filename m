Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80551C0F
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFXUNA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 16:13:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35919 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfFXUNA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 16:13:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so7528090plt.3;
        Mon, 24 Jun 2019 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=USqQq4RtkZv36krdefC1dbFXyRTkrhEsSnTWhHiiTX8=;
        b=UAq2Et+pia3d9R0qhpF83A5UD8W5EaC75PZwCmcojVBmj9F2Hd5oIW961tVXyMKD7C
         hEC08TQzOBAfOIRTuPBmiotLtC2+RxH5g3gw7BvahJEm7NhHG8suI2vZxwPttT+cjZEL
         CExcnFb8IRjqeuXOqPv774ZUfr3UqB2AA7HWXuV0NEfXOqf2bauGj5T2S8/6HYswHjhJ
         029RkOopSH+uHZaupFpixjLVKa5II6QZWMa7JPwyvLiMYrQV8WaFuzaxN3K70YRB9/Xw
         574ZX7VUYSsf/8DjRBYBXban/YVnPdFy40FrSFV2RjmhGm8ZlCf6jkcatD2+HXJSajzt
         R5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=USqQq4RtkZv36krdefC1dbFXyRTkrhEsSnTWhHiiTX8=;
        b=EtbldXTAJRJxmFWcINDeIowLsZTSSLNu9c+StbrYiVOaVJB2rcwZnGFdnlcQZMhcfj
         svsqXlf2YYxZ0XXxJpliRVwduma3a75unSninCVLnUDzxe5t0lmcEIeEzfMIwbD5zKYd
         b2WzHcTcxnpHYoTGl6COg+AXRStB+QK/JyRQeJANc02rUSQEOJt3lZAqfKIU0A4sW8VU
         TtHGZxrkYyTlkVYZhaOVb9Yg/Php82gV3yP+TcDJIHYCPn5iopjR+kWnQbnXIaRfveIp
         q4ydx89C4IeK7y51npvSR9Juzt2WBRhekXbNwNA62ZvzqyRwaflsW9TI+YrfFxBSUxNs
         k4dg==
X-Gm-Message-State: APjAAAVaoEY/mpeR0raHUCqgFyKWrfMmSmAmWBFrVwTQDNQdOtK9Z+dD
        ki9iNj64KgNMKGyogf40ELk=
X-Google-Smtp-Source: APXvYqzPi32d1jAllYMuwcsfTzleeJQdzD8IdW8C+BXnyAZqnrl6HAe2CEmCZYz1VuODNORP3ZlQrw==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr62437831plo.97.1561407179277;
        Mon, 24 Jun 2019 13:12:59 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id g9sm9863715pgs.78.2019.06.24.13.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 13:12:58 -0700 (PDT)
Date:   Tue, 25 Jun 2019 05:12:56 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/5] nvme: add get_ams for nvme_ctrl_ops
Message-ID: <20190624201256.GC6526@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <2c916063e19cc3f33376d7bb0fb8a5ff10ea42db.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c916063e19cc3f33376d7bb0fb8a5ff10ea42db.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 19-06-24 22:29:05, Weiping Zhang wrote:
> The get_ams() will return the AMS(Arbitration Mechanism Selected)
> from the driver.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Hello, Weiping.

Sorry, but I don't really get what your point is here.  Could you please
elaborate this patch a little bit more?  The commit description just
says a function would just return the AMS from nowhere..

> ---
>  drivers/nvme/host/core.c | 9 ++++++++-
>  drivers/nvme/host/nvme.h | 1 +
>  drivers/nvme/host/pci.c  | 6 ++++++
>  include/linux/nvme.h     | 1 +
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b2dd4e391f5c..4cb781e73123 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1943,6 +1943,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>  	 */
>  	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12, page_shift = 12;
>  	int ret;
> +	u32 ams = NVME_CC_AMS_RR;
>  
>  	if (page_shift < dev_page_min) {
>  		dev_err(ctrl->device,
> @@ -1951,11 +1952,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>  		return -ENODEV;
>  	}
>  
> +	/* get Arbitration Mechanism Selected */
> +	if (ctrl->ops->get_ams) {

I just wonder if this check will be valid because this patch just
register the function nvme_pci_get_ams() without any conditions.

> +		ctrl->ops->get_ams(ctrl, &ams);
> +		ams &= NVME_CC_AMS_MASK;
> +	}
> +
>  	ctrl->page_size = 1 << page_shift;
>  
>  	ctrl->ctrl_config = NVME_CC_CSS_NVM;
>  	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
> -	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> +	ctrl->ctrl_config |= ams | NVME_CC_SHN_NONE;
>  	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>  	ctrl->ctrl_config |= NVME_CC_ENABLE;
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ea45d7d393ad..9c7e9217f78b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -369,6 +369,7 @@ struct nvme_ctrl_ops {
>  	void (*submit_async_event)(struct nvme_ctrl *ctrl);
>  	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>  	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> +	void (*get_ams)(struct nvme_ctrl *ctrl, u32 *ams);

Can we just have a return value for the AMS value?

>  };
>  
>  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 189352081994..5d84241f0214 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2627,6 +2627,11 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>  	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
>  }
>  
> +static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
> +{
> +	*ams = NVME_CC_AMS_RR;
> +}
> +
>  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
>  	.name			= "pcie",
>  	.module			= THIS_MODULE,
> @@ -2638,6 +2643,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
>  	.free_ctrl		= nvme_pci_free_ctrl,
>  	.submit_async_event	= nvme_pci_submit_async_event,
>  	.get_address		= nvme_pci_get_address,
> +	.get_ams		= nvme_pci_get_ams,

Question: Do we really need this being added to nvme_ctrl_ops?

Also If 5th patch will make this function much more than this, then it
would be great if you describe this kind of situation in description :)

>  };
>  
>  static int nvme_dev_map(struct nvme_dev *dev)
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index da5f696aec00..8f71451fc2fa 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -156,6 +156,7 @@ enum {
>  	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
>  	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
>  	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
> +	NVME_CC_AMS_MASK	= 7 << NVME_CC_AMS_SHIFT,
>  	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
>  	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
>  	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
> -- 
> 2.14.1
> 
