Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC026A49AF
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjB0S1Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 13:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0S1Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 13:27:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2ACDFE;
        Mon, 27 Feb 2023 10:27:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kb15so7139225pjb.1;
        Mon, 27 Feb 2023 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGr1oL/pZpPll19+c3ioRmhLkSsTJHby1AuhBJm//pc=;
        b=AXLk46Xo38NfyHxtx8zulMsDJlEFXxboaZ7CcFKXsR8lysmnKJevshrI8i8WK3fJTF
         uWR4w1WfELt0Mq+azcWdHPKbNrLZ4SbbMF+Dkc5RflxcjT1jViFzgFaN1/07tFwvLGFX
         NcxpDm+af0Io/ke056P3+ooazUZqZtyEcVpRp3fNMnNcS71FCcdqPYfKgzryOUsxSAj1
         7fUCo5vF3vh8qRZlYEh/4zoRmerPgXNLa9QB4SRDNimzCG6/nMmNK209HnPte1nf7Wu5
         VnR2Yv9PRATCOS9AS8FmpBZfQeJ7dumwjV4T5CKMSSKlVeffBA9uLpS0wEJocpilftqF
         uOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGr1oL/pZpPll19+c3ioRmhLkSsTJHby1AuhBJm//pc=;
        b=P7mFT0FoBjxFqVzBHEcteI840CgVoPfdT/CsDUFvkgd+/BRQtJgkdjl4sBbkXYvlvt
         1nn5GuuC1fIz2JnR/yJVYHAkmhhsaaKuqS+UtQ/UaKBfuXUk/DwVTmXwLNS9qD3KAEgy
         F5Q/fI2gAEO0o4U9wao7wTSy7qw0Wrvw81VJXByRD82ULej5h+fes9PzBBZA7SE199q6
         AOJVAxYvZCETHgaE11FG5Iw+NyPaY8xsQ8wxhuUxfkY6LymBn/ZMJ+kcREVZ22Jpp+M6
         AD/Pbnm5mTeWovky6DfpcddjAF4WRJTkDysOyj+rsDe7JVc5nHHAzHnpfIsxTS4+7PiS
         8CjQ==
X-Gm-Message-State: AO0yUKVLCtkVpYAly6nlTLFhQphbvQacTcmfuvqDl2aDnreV8TZcaUm7
        pSwREWWRZQ7sJUYmWNvpT7w=
X-Google-Smtp-Source: AK7set/TfJvvSIOtVjF7wj4W9M7274mKsz1GltNZ8tgBx1SdHt58gDyLIXoAp9A8vaqeH0TueFgGeA==
X-Received: by 2002:a17:902:cf50:b0:19c:d796:9abb with SMTP id e16-20020a170902cf5000b0019cd7969abbmr10124190plg.41.1677522442998;
        Mon, 27 Feb 2023 10:27:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001991f07f41dsm4916163plz.297.2023.02.27.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:27:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Feb 2023 08:27:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de, josef@toxicpanda.com,
        aherrmann@suse.de, mkoutny@suse.com, linux-kernel@vger.kernel.org,
        leit@fb.com
Subject: Re: [PATCH v3] blk-iocost: Pass gendisk to ioc_refresh_params
Message-ID: <Y/z2B+153X0PYpjO@slm.duckdns.org>
References: <20230227151252.1411499-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227151252.1411499-1-leitao@debian.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

A couple minor nitpicks:

Can you please add a short comment here too saying that @ioc->rqos.disk
isn't initialized yet when this function is called from the init path?

> +static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
>  {
>  	int idx = ioc->autop_idx;
>  	const struct ioc_params *p = &autop[idx];
> @@ -808,11 +808,11 @@ static int ioc_autop_idx(struct ioc *ioc)
>  	u64 now_ns;
>  
>  	/* rotational? */
> -	if (!blk_queue_nonrot(ioc->rqos.disk->queue))
> +	if (!blk_queue_nonrot(disk->queue))
>  		return AUTOP_HDD;
>  
>  	/* handle SATA SSDs w/ broken NCQ */
> -	if (blk_queue_depth(ioc->rqos.disk->queue) == 1)
> +	if (blk_queue_depth(disk->queue) == 1)
>  		return AUTOP_SSD_QD1;
>  
>  	/* use one of the normal ssd sets */
> @@ -901,14 +901,19 @@ static void ioc_refresh_lcoefs(struct ioc *ioc)
>  		    &c[LCOEF_WPAGE], &c[LCOEF_WSEQIO], &c[LCOEF_WRANDIO]);
>  }
>  
> -static bool ioc_refresh_params(struct ioc *ioc, bool force)
> +/*
> + * struct gendisk is required as an argument because ioc->rqos.disk
> + * might not be properly initialized
> + */

Here too, let's explicitly say when it's not initialized.

> +static bool _ioc_refresh_params(struct ioc *ioc, bool force,
> +				struct gendisk *disk)

Given that __ are about an order of magnitude more common in the kernel,
would you mind renaming it to __ioc_refresh_params() or e.g.
ioc_refresh_params_disk()?

Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
