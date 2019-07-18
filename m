Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06E56CF48
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2019 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGRN7U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Jul 2019 09:59:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37325 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRN7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Jul 2019 09:59:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so13946659plr.4;
        Thu, 18 Jul 2019 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NUBO4YCRDgiN4UTvulVlnqUREX1vo2A5l3XRIoGqGME=;
        b=HB2wxzPrDEbYvHZRxbCo9QRYUEqFFdl/rLdSPDNQYHaEXWjZkxMi5D3ZDvSHU+GimH
         SjcBOAyXrOFaRY0/xrjsItgWCiNyLkHR22zMFkHeN5NIyS9rLfXrSGDxiRtB3m76QUSe
         /zMrEvjf8vwCUkix56WOcpeoCu3cMSS8jTI5uDV9f7v2E+6pf01BfrasSPbmS1t2lb0d
         jIylXQGdbBV6wsnHLlR0FIX4ZevsifJ+0fXpE9MeaNqosdEUDzHJZmINobNAcB5l20d8
         C+arXOCsEGPjD+C3b/NqjC0jhOHPsaVVIwQx0NzkHOVSIdU5STuQzJ1UChfJRB7Mhe9y
         dbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUBO4YCRDgiN4UTvulVlnqUREX1vo2A5l3XRIoGqGME=;
        b=fvSLcgTL6BK0k1H/x/TiRCGME4y7Iyd9IVib1+OC6syqTdV0V+SUYR3nJ3DyMck3yL
         hM2K2Vm6C7ScTh4Q6bdHrHFHIYKJpqKiNwCQYdF8OBs3PMPnKvmB3ts4XyTaHAVL2Kvl
         v8LwWulHa898iuwetIcv0LpsUUGFc2VkLvXVI5GeU0Y7kFtOe3h3iF4nFthyD+mJiCoG
         VcNYxiAzjetfi2xptnpNV4awsOhPijoZkrA+QseDB9HxH/wwAY4N7NlzU0GM9DKJRorZ
         ijRc8hnAJY0FblhLbuO+uC8EadoR2425nXSahTVQj/q34bP3N+gXIAxufzcVN8BT0CSC
         s4cA==
X-Gm-Message-State: APjAAAWOWIHuHTuH8YGMEYDqlPo5CTeChBzcemrS5rdqU4NbYTHCU1tI
        pgM6o+eGGnVpNbX9+mxV5s8=
X-Google-Smtp-Source: APXvYqx173fSB7lx9dKAPXlsiipxa5JyR/hpYuhUgImVW+wGnZmLIzDlKvpQwh4ZL+yVrTeDqFz9yg==
X-Received: by 2002:a17:902:5c3:: with SMTP id f61mr46783088plf.98.1563458359244;
        Thu, 18 Jul 2019 06:59:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:ef9b])
        by smtp.gmail.com with ESMTPSA id e11sm33141264pfm.35.2019.07.18.06.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:59:18 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:59:16 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/5] block: add weighted round robin for blkcgroup
Message-ID: <20190718135916.GC696309@devbig004.ftw2.facebook.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1333161d2c64dbe93f9dcd0814ffaf6d00216d58.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1333161d2c64dbe93f9dcd0814ffaf6d00216d58.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Weiping.

On Mon, Jun 24, 2019 at 10:28:51PM +0800, Weiping Zhang wrote:
> +static const char *blk_wrr_name[BLK_WRR_COUNT] = {
> +	[BLK_WRR_NONE]		= "none",
> +	[BLK_WRR_LOW]		= "low",
> +	[BLK_WRR_MEDIUM]	= "medium",
> +	[BLK_WRR_HIGH]		= "high",
> +	[BLK_WRR_URGENT]	= "urgent",
> +};

cgroup controllers must be fully hierarchical which the proposed
implementation isn't.  While it can be made hierarchical, there's only
so much one can do if there are only five priority levels.

Can you please take a look at the following?

  http://lkml.kernel.org/r/20190710205128.1316483-1-tj@kernel.org

In comparison, I'm having a bit of hard time seeing the benefits of
this approach.  In addition to the finite level limitation, the actual
WRR behavior would be device dependent and what each level means is
likely to fluctuate depending on the workload and device model.

I wonder whether WRR is something more valuable to help internal queue
management rather than being exposed to userspace directly.

Thanks.

-- 
tejun
