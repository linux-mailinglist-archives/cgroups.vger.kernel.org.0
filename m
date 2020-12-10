Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6152D612B
	for <lists+cgroups@lfdr.de>; Thu, 10 Dec 2020 17:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbgLJQGk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Dec 2020 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392294AbgLJQGg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Dec 2020 11:06:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0CC0613CF
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 08:06:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so6052350wrt.2
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EEM0AX878xSa8V2cvUDpTLDczQ0IGzyz0LRReW9tzA=;
        b=dG3nDfcSFKcJqfMUlDBawK6U+/17xUIuG5w7oEcJKBYdW1zerFAMxTR27Vw3ED9rWV
         aZ5xpsrUl1k/73I4w1FR6llyHh342rQEBBSuerrIpeeWaTwd0YgiGKLpWIRVtTWvd0Vr
         OvEPfWDYhl0k31LxHGSu2Y79gbq2+C/UQRm4+nfafn5ylsnB1sL/jMp6VoQ1CSC8wFkX
         TGklkiZNfuDYk9kbL+3VXuWSYYQ0/jsni1x+f55I0oy0LfaTM5ZgzIiw6+vZ2IaGg5TV
         VkN2qdkxGVbKvtdqLvrMGA2oN0cFpRSU6eGeFz2VAY046PYj+H8zuJcV2RZuDHBwQt/o
         VW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EEM0AX878xSa8V2cvUDpTLDczQ0IGzyz0LRReW9tzA=;
        b=YX0/dWIOn8iPNZwBKbcY1WXuFhsdpsp4TZxO0tSlR3RwriwTJZlyNNB8wKAf5Kuz3f
         pQpgDARjbfrsFrpcn1gf4QenIzEAKE9YXAJ8UN1EYSlw0+wxnWsrJI7gGbz+5BWj3fBx
         LFAoSvVHGYZjWIfL+f4UFn0ou4UMJ0gzsnyGZHZBV5oI9FrDJNM/yb8EIqOfkLv+/BUE
         Y55SlFqCneLn2sUUYlxXnnC7l+7ETugWOLbsb2AsOOznUaD3iW54HTq0SjWrQoxdzvSJ
         M7kpFA5iIWHjs0mqRivTP8ufIveo6UBx18/J3Pd5wmmT1SohGzsdnQJPdBKf3AOIAYzx
         Pl+A==
X-Gm-Message-State: AOAM532TudZgv5y3ve6kfNF1+UyEf+emI0v72NqKSrPSl7YEMJ7WdOa9
        xTxGIiyaiszpj+CotP3f5IAB9A==
X-Google-Smtp-Source: ABdhPJwbsAebsVatgwJVP7G/BlySZfheiXSb2ekaT+aAULkzlUatfjHBeww5kzznvVZDMQ8OamZaBw==
X-Received: by 2002:adf:9124:: with SMTP id j33mr8598967wrj.376.1607616379710;
        Thu, 10 Dec 2020 08:06:19 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id x7sm2719625wmi.11.2020.12.10.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:06:19 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:04:13 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v2 01/12] mm: memcontrol: fix NR_ANON_THPS account
Message-ID: <20201210160413.GH264602@cmpxchg.org>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206101451.14706-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Dec 06, 2020 at 06:14:40PM +0800, Muchun Song wrote:
> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.
> 
> Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

But please change the subject to

	'mm: memcontrol: fix NR_ANON_THPS accounting in charge moving'
