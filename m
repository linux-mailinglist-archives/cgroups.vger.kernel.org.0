Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62012FD614
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbhATQwo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jan 2021 11:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391507AbhATQpQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jan 2021 11:45:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA0C061575;
        Wed, 20 Jan 2021 08:44:34 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c12so11158218qtv.5;
        Wed, 20 Jan 2021 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02Z6TkAFxEXED71l0h/isCElQR7bDCewo1h0J01+Wq0=;
        b=ZFT116uGUty55tAT/lPBU+jK/pTkJif9rwc6f69o4n9DiLgm279sPG57CMy/5rnzVk
         PfBUJZPULqvQU9M3UuFhTEVVFQDbx3agVb/qSmGHKpFGfnZmuW/e6sNCi6YPr7pj/UGw
         V0kAZCN/2Pw+FzXKWB1Sk0RImOk4aaOwceptZTX94mOmjK08NFcsuHETyfHdkx8u/qL8
         k4bgiPA2PWl7kPfKTu2hHcPmNAgfukZKjldhOkoPIHLfQDSGrwkhs/9uRnn+ifaD/sM5
         ip1lcO42mVBRGiI1C9pdaeE+nTYOlrDsPgYHzi+vSOkighBozKL5FHt/uXzdZp75U53F
         fczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=02Z6TkAFxEXED71l0h/isCElQR7bDCewo1h0J01+Wq0=;
        b=mveUfedZRVKqKNbz3bgdkqJvzwN7W2HJC04mG0WuzVaEppfrqdbJ4lZDIYheWSkEP0
         mpujpBEjB3LMiraS/rCagsnSUScV3ufNS1uc2C5HppTCoCekCIY2NvLDJJs0zE479E4T
         B3a3ABF3KXBV4N288q2L1ysMxoqjEgLCfEc9501kiNSzS+0bjPuLDpOQqtiU0JcfS8e0
         040d3YVR8CPoxPJy6tpEBtV/q59BCmAYGAXdF6ISWj2O8l9IcqnSSeef+v+kMK6bvvgq
         Gs7y9Tx0EA/XelDFUF7z/aPCsW6Job8sXcJwQP8QhleJkPThwihSwTREl9R9SfCI43d9
         E3yw==
X-Gm-Message-State: AOAM531iRLNMzbzJebD3BLA0qwNxMRMXhJabYZjl08+PSqJjUKUKzMoE
        COpNG5jcr1h0hHzbjtcj5eQ=
X-Google-Smtp-Source: ABdhPJxn1raxfX/V/yiPGSWI1xjOUpn9xVevENN/MHdwBus5VX4sEhwoUzZC3JMITmzBq/bYJcKmZg==
X-Received: by 2002:ac8:4f51:: with SMTP id i17mr9627134qtw.78.1611161073787;
        Wed, 20 Jan 2021 08:44:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1b8f])
        by smtp.gmail.com with ESMTPSA id f125sm1628553qkd.22.2021.01.20.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:44:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Jan 2021 11:43:46 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/10] docs: cgroup nits and fixes
Message-ID: <YAhdwtMS98iPma+S@mtj.duckdns.org>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 19, 2021 at 04:18:14PM -0800, Kir Kolyshkin wrote:
> These are mostly formatting fixes for a few cases where html
> looks plain wrong, plus a couple of added cross-references,
> and a typo.
> 
> All issues spotted while reading cgroup docs. Results are checked
> manually for both html and pdf, using both Sphinx 2.4.4 and 3.2.1
> for rendering.
> 
> All commits are against docs-next@52042e2db

For the series,

Acked-by: Tejun Heo <tj@kernel.org>

I suppose it'd be best to route this through the doc tree?

Thanks.

-- 
tejun
