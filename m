Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D6636890
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiKWST1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiKWSTA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:19:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8ACEE27;
        Wed, 23 Nov 2022 10:18:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j10-20020a17090aeb0a00b00218dfce36e5so2230015pjz.1;
        Wed, 23 Nov 2022 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+wiUlX+ZzbOJle7HnS1krIiCPjVF1I+A5cD8cm1XM8=;
        b=oZeeBnEeGmvjRkvxpd5dd4v1+nkW1yLWhjB1DNJmqQKV0eIUzEyRNI9KXZBGZL4JO7
         Vp9VbeF+D/aoQ5F2L2rjPMaGOqgiO5HjnnKWNF+YJx2R7+GsbiR4jal2MHBPE6eg+jBN
         wSFp9cv7IbUn5M+i38B6LfWvRvU5V0CvxcTXkubZwuVPzo+uS4c4JlyO0SlhL2zoydzQ
         t5dcixwsUZnz1vGaGwou5EWvGYvjK8brVFpBVEL8Mr15CRiXWX+H81iWY12EPefqUXpO
         4tEYMm7piYEKqHN3IdOto/oo+KvUOXVUXPaMZw+0hzmtFoJZACW3lRySAU7EWmsi5KXB
         slgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+wiUlX+ZzbOJle7HnS1krIiCPjVF1I+A5cD8cm1XM8=;
        b=mLH/iwIn8p/WsdbOKOTyUv5qBVYPR+FccX76A2fAsxlCfcWQZqVhAn/wrH5re4wQ4C
         iZ8IaAs+GWHgoZqPqR95jj+P4pEkXU9IHQs/EjkTQEbYZVCQyfmvjuLUOsACGLnJU2nv
         jq1R3twnay4awY8rPi57Ug5aDkh7Q1irHFayVaNJAlfeQW6LZjAgf4dZRUXdoQlUONwq
         jP/SioV0ZjvZvl0Wlt+4H7lLandAXdDIJzSsYYxS9lZhfFHKmi2sOp/uoauJJq62sajj
         HGb92Ip8/NqEz/08jDHraZgU7V29b9yUxXDkG1tbCV8X9+MYUy3OzF1/5sjJRRJ4a8Hl
         O6/g==
X-Gm-Message-State: ANoB5pkGFbGbXbLj1nYGs4G5v6i2cWYX5MtRfn443xkiO+ld3WrNIdV7
        J5iiFUMc7tB9yToHzfO9bo0=
X-Google-Smtp-Source: AA0mqf5FyOlv0J80ex/Z/ir9XJCw/aSk4lvE198n8rm4YG/kGTkL6yXagm4WBwk+1YoqSpUb++HGug==
X-Received: by 2002:a17:902:c702:b0:189:4bde:53c1 with SMTP id p2-20020a170902c70200b001894bde53c1mr2799075plp.1.1669227538388;
        Wed, 23 Nov 2022 10:18:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a1a0b00b00218cd71781csm1706081pjk.51.2022.11.23.10.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:18:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:18:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] blk-throttle: correct calculation of wait time in
 tg_may_dispatch
Message-ID: <Y35kELlFkI/BtkqC@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-5-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-5-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:54PM +0800, Kemeng Shi wrote:
> If bps and iops both reach limit, we always return bps wait time as
> tg_within_iops_limit is after "tg_within_bps_limit(tg, bio, bps_limit) &&"
> and will not be called if tg_within_bps_limit return true.

Maybe it's obvious but it'd be better to explain "why" this change is being
made.

> @@ -939,8 +926,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  				jiffies + tg->td->throtl_slice);
>  	}
>  
> -	if (tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
> -	    tg_within_iops_limit(tg, bio, iops_limit, &iops_wait)) {
> +	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
> +	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
> +	if (bps_wait + iops_wait == 0) {
>  		if (wait)
>  			*wait = 0;
>  		return true;

So, max_wait is supposed to be maximum in the whole traversal path in the
tree, not just the max value in this tg, so after this, the code should be
changed to sth like the following, right?

        max_wait = max(max, max(bps_wait, iops_wait));

Thanks.

-- 
tejun
