Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9706051C2E
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfFXUVO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 16:21:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40769 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFXUVO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 16:21:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so8146335pfp.7;
        Mon, 24 Jun 2019 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2URUWLi/i37v7K+14kEpM0KZq8GpN2UCZhu67teNXY=;
        b=OOw72oySzClnxongvl16fJuTXhexhrWE/q4y8lfFonZMTpCIt3o/TI1qLmOLR2poFw
         MfAzSxygGpHJ7dcNfmkrhq+wSJDkxi9mi4U6vGEYqPo7Z0/SZ1u5HbBv+1kNr+Vl3u0s
         F8yAH7yQmycnjpiTUwjoNzXjXm7Tg6Fin3f+eTmXn0ZFO85FDQsCrfdJqahzciKrXFkn
         VQtvoffQWEM/CACMX83eHL+5qhZ0wFH8WFwCaB21G0nyLlO0jWCOic5j6LQuIJ8RBLjb
         F9ijJXTLAzoaX+nRx8yJWTZWQF9CpAeH2Urym0CAUzdRTr+UxRzqN8KZXKi2KXakuC3k
         XvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2URUWLi/i37v7K+14kEpM0KZq8GpN2UCZhu67teNXY=;
        b=iglCQg5abz7cOxnTqJj9UOcAAOH4IBj9JRb/eN6YxSwG2mg5RdBfN/5z30qpulahxU
         pdUVTN8KS92e9RkObBzKH6n9DVZHOQMOfc8qJ4whIsQWJ+n1foFQGMtgBjLC7hQrbP0R
         YJy9qe0Umh0c6yCOnrSwGyYP7b3wWIXW9WVS1hA8jFaOhGRNYVvClq8L6lrhhuoNPb9w
         /4J6brF0+gSXlqfic7qE19kocPUtGq04x0kqbL8WCKUJ4yTGGb/FKKBZHV9uF7yI04jL
         5FprGPI7EPLU2tCNQcWfURzlvPIqCom/jH338yBAmZ5ndsE15Qloq0ahh0XM7RZVa/zd
         rvEw==
X-Gm-Message-State: APjAAAWqf6aCR4Rv3uMAw1dQ3e41xt4QOnpDzi7UKXLIkw7iOP7l6F7g
        nAf693iTtIDrHgNSpHgO6F4=
X-Google-Smtp-Source: APXvYqzN3DSPGn+3YbngXKJ00yEQiBNAAdY0MNO6THf0uc/OgOi7WJGWhIs2NZDIA+kWIeC2dM5YLA==
X-Received: by 2002:a63:52:: with SMTP id 79mr34365144pga.381.1561407673484;
        Mon, 24 Jun 2019 13:21:13 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id x25sm12526216pfm.48.2019.06.24.13.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 13:21:12 -0700 (PDT)
Date:   Tue, 25 Jun 2019 05:21:10 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 5/5] nvme: add support weighted round robin queue
Message-ID: <20190624202110.GD6526@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> @@ -2627,7 +2752,30 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>  
>  static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
>  {
> -	*ams = NVME_CC_AMS_RR;
> +	/* if deivce doesn't support WRR, force reset wrr queues to 0 */
> +	if (!NVME_CAP_AMS_WRRU(ctrl->cap)) {
> +		wrr_low_queues = 0;
> +		wrr_medium_queues = 0;
> +		wrr_high_queues = 0;
> +		wrr_urgent_queues = 0;

Could we avoid this kind of reset variables in get_XXX() function?  I
guess it would be great if it just tries to get some value which is
mainly focused to do.

> +
> +		*ams = NVME_CC_AMS_RR;
> +		ctrl->wrr_enabled = false;
> +		return;
> +	}
> +
> +	/*
> +	 * if device support WRR, check wrr queue count, all wrr queues are
> +	 * 0, don't enable device's WRR.
> +	 */
> +	if ((wrr_low_queues + wrr_medium_queues + wrr_high_queues +
> +				wrr_urgent_queues) > 0) {
> +		*ams = NVME_CC_AMS_WRRU;
> +		ctrl->wrr_enabled = true;
> +	} else {
> +		*ams = NVME_CC_AMS_RR;
> +		ctrl->wrr_enabled = false;

These two line can be merged into above condition:

	if (!NVME_CAP_AMS_WRRU(ctrl->cap) ||
		wrr_low_queues + wrr_medium_queues + wrr_high_queues +
			wrr_urgent_queues <= 0) {
		*ams = NVME_CC_AMS_RR;
		ctrl->wrr_enabled = false;
	}
