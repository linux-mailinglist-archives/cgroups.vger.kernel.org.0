Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC61B2A27
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDUOj0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUOj0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 10:39:26 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D44C061A10
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 07:39:25 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q31so6598565qvf.11
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FUghwdK61ELIcdqNXkNEUPkemM8u8aFA3cSbQm57Oy0=;
        b=gFxehvHGSNlG++mszljqSCAK7x9JFhjfQndMRxcNzeicsRBEWHLOnuSk7TV/f0lpJS
         hI40Kn4d4RhA2dhOIjiFgB4c9koyFw954Gi9PeFxAZnTNJx7vt622EPZLNpn9eUYH9le
         O9pbbJh5hVwKmuS42wfYZ3Y+WPU27d7VfvhPFCoLpJ467jhpzjCYj6m1WrPsIbmBx/Kr
         4h/THAUC+GEjA1w+FrC360VuFTaR4mLjUzraOoMvViF56WaYnVAS8b6VWjmlABi86u0L
         2yIVk9FFEx1KfLomk93emTZXN5qcyqBBKpgW+00of/GRzhQUA58c3n0SxXHmwIwDoTJh
         opFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FUghwdK61ELIcdqNXkNEUPkemM8u8aFA3cSbQm57Oy0=;
        b=EOuVMKg5kpXo4ypzc6LaWAsVc0fn73O8DdMQpJoWvfCzNB1WUhVGXzSJtQlSvHYGQS
         6eOeyGz3LoaPAPIl0F3fHVrev7HFxLbIfbodrd84mmWiIMUyhEyHZH6soruNSp4yfMfJ
         pevAEoLuErfxVd4K4d38HGgDi7OcVVSTvs8Xpiri8jMaBj5uRfLkray4rNeZixCA7tNo
         bZZDrZX8SnurV1dFe5Y3jmV2zIB19q88XKt+NhUWFvoAvxjmQxJfmzAB6AVsmDcGBVZm
         NIsCm/A4ZmJRw7aA/k8bfZL7Ep538nI3QlvZrjNNFmthMi9iGhC+hsxwmTeLf5VCnH3a
         wLzg==
X-Gm-Message-State: AGi0Pubm4y+hwfBVE2+1kly4S7f52WuZvttIM2hetmBU7qGNXD3a5TdY
        IWU3I6YxNJFUntTDuU+3w1UO7g==
X-Google-Smtp-Source: APiQypInpg4gUIZ3ZyekCXLwMFg9UBr6vB/iUDK8KN7FOJEIEMxL1qkg7RMokE8ry7h8Zwv72b5e1g==
X-Received: by 2002:ad4:49d3:: with SMTP id j19mr19534989qvy.78.1587479964857;
        Tue, 21 Apr 2020 07:39:24 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id l8sm1864795qtl.86.2020.04.21.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:39:24 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:39:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Joonsoo Kim <js1304@gmail.com>, Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral
 part of memory control
Message-ID: <20200421143923.GC341682@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-16-hannes@cmpxchg.org>
 <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alex,

thanks for your quick review so far, I'll add the tags to the patches.

On Tue, Apr 21, 2020 at 05:27:30PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/4/21 上午6:11, Johannes Weiner 写道:
> > The swapaccount=0 boot option will continue to exist, and it will
> > eliminate the page_counter overhead and hide the swap control files,
> > but it won't disable swap slot ownership tracking.
> 
> May we add extra explanation for this change to user? and the default
> memsw limitations?

Can you elaborate what you think is missing and where you would like
to see it documented?

From a semantics POV, nothing changes with this patch. The memsw limit
defaults to "max", so it doesn't exert any control per default. The
only difference is whether we maintain swap records or not.
