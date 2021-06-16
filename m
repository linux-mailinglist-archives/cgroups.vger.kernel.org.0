Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8373AA061
	for <lists+cgroups@lfdr.de>; Wed, 16 Jun 2021 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhFPPvo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Jun 2021 11:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhFPPvb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Jun 2021 11:51:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C96C061095;
        Wed, 16 Jun 2021 08:46:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q16so3058891qkm.9;
        Wed, 16 Jun 2021 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gAbGl9PUVrieIDOPPvfXysXyAMbFr8wfY+I6z1ScrTg=;
        b=kpgilGno7nEPvy3nM51vemWrL+pBaMW+FVRrClekQ10IdxjRw5D5h7Ty8l31rn6shF
         zdw6ht9g6WxiTgflBF/HQq73fl4sfi+TlLVcddDBpf3aiGZoQqwfYDi621CIMsA9+6LI
         9wjnTBUwbxOSohWmUHZXRqODWpx4kxTh8RUTnvJjwX6djPGvGiwR7iIoYO7F/GJdf6Iy
         Zyb0D/pitJClgTkW+PoNaIWgv0M2/1UIYK4w1CaHUtgMjBAbXBo2dFcB3hROppBNo8u4
         64F2SaDorlwRVlJljIrWAnWns76BTeysENNvocOZdFAssrNRtXtkgJePuVoqFWifdYdS
         dEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gAbGl9PUVrieIDOPPvfXysXyAMbFr8wfY+I6z1ScrTg=;
        b=hRfycklEADtrBILdQYQbp2cro+AIESYdj/lVnUF09bo4nGX4T/IqG1PTEeWRRvxR4Z
         Wg9cbSxwodrcnFwRTWU3cYxmthLvNhFU6U21XXi3ZHi8A8r2S6T20ZOm4FUsFYDI5OSw
         LePw6qJaMSg9FssQJqYcEKoPDyxoN8kzticv/45lLqNzQHIrzkAKYngYxhq4vbsamSRa
         p9qUd+3f64/jkl/j2XnTpLHr7nvp1Yh8LFuBQ1JT27VGAcymRh3kmyF9bRS41bjfatHS
         Vw03MkT1akqo2hO5vpL5ozOYlrX8xFjPx3+QRvNRWQMTEDUNtkYxAOlpJ2uw1khvs5Up
         3FNw==
X-Gm-Message-State: AOAM533B/K2E2W8DeSQXH9bx2+/cmim8/RIVGuxxwRbpRVuNZHytotse
        mRjPdy16sD+XqWcTTDA17uI=
X-Google-Smtp-Source: ABdhPJwCcZ1qRg5NHLDPDEtT6co3BKSf0C4lfwr7S0PG8T7ROitbmMFoiGrVi+lir7SWb28i1stHqQ==
X-Received: by 2002:a37:6c46:: with SMTP id h67mr683623qkc.383.1623858386396;
        Wed, 16 Jun 2021 08:46:26 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id m126sm1828290qke.16.2021.06.16.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 08:46:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Jun 2021 11:46:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        axboe@kernel.dk, paolo.valente@linaro.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/3] add/update/fix BFQ docs
Message-ID: <YMoc0Tu/DyeKouc1@slm.duckdns.org>
References: <20210611030737.1984343-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611030737.1984343-1-kolyshkin@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 10, 2021 at 08:07:34PM -0700, Kir Kolyshkin wrote:
> Improve BFQ docs: fix formatting, adding a missing piece.
> 
> Fix cgroup v1 blkio docs which are not updated for CFQ -> BFQ.
> 
> Patches are on top of the latest docs-next (commit acda97acb2e98c97895).

Acked-by: Tejun Heo <tj@kernel.org>

Prolly best to go through the block tree.

Thanks.

-- 
tejun
