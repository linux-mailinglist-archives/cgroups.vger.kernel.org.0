Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705C82D61F0
	for <lists+cgroups@lfdr.de>; Thu, 10 Dec 2020 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbgLJQbS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Dec 2020 11:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391791AbgLJQFC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Dec 2020 11:05:02 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3CAC061794
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 08:04:21 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r14so6029187wrn.0
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Uj7y3A8V2AwfLN+Pqn8MEopt38Al+RWbGM3+oeOM5I=;
        b=C1AKu65PSoE7zQcCNy0JQRQoNgwkUc0P9zhgctECcKh2D2QvnaGL/kiQGLaAUPEWaf
         ORRPEgv7zEwgBlOYKCoVem69+rPqrnkmdBRJTX9zh7pZS/K+n5f0RtDYbXvWCUp0JRpo
         0wXQoSNA4pBGbpwJHKw6jX94wupKYKqYIe4yRh5fGSGwsyg0pIAwgOZeNPYdzmtWrckV
         N14VPhHIRFwm7QftCfbb0M16p+2BInbAx6gHoZkqXnWuG3zEExM2DTEP4aA5k8V3ydJa
         O4ze2uJfmUW6B2iTyHyVzbAn2dQt6f22d3RxlIZqOO6F5ZWBz65O3UvSHF0zV+vhT95C
         Wr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Uj7y3A8V2AwfLN+Pqn8MEopt38Al+RWbGM3+oeOM5I=;
        b=bQMGGTLeff/rO+voASQkpQD2b7T6ZAlLheUPMqZZPywywCDLjjcTGsjPcA5cAoO6cX
         LooCF1nJHN8BKwxHE42QfqxxEgQOv6jkfhSX0LdX4tUZBdtj+K0uAI157VpNwKpByKp7
         +TzUYU9rMgzanP9PEM8vh1DSSFCVvzi6gyi72QDOwStpn7bhrY01AfkXYKiCCIq8Ece0
         YWOgYQ/rV9fyCAI0Cxrodg+OgPKSON65E0cMm9emx14BQ3ARfBB5UgVnoCz6IhVn/ZXn
         YEJ03iYzy+GrDbz2Sf7CcEL3L2KelsXvr+zq5bChUOS2/2A487A7KJ+FpMrs6RDOfMYt
         fuaA==
X-Gm-Message-State: AOAM532fOBHUBnMa5b974lIvsPzYyNtjg+iJzEb2eeB5PDVJ90fsJWXz
        tjKzY0/7cRajcfVu1LxfPC/D9g==
X-Google-Smtp-Source: ABdhPJxAhmFLnIoY010MjFHtQXoLlmelUaEajcB2sidw/qB+PZ2ByzxgE4Jc6uiPBxPmNyTH1CpVhA==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr9203280wrr.26.1607616260242;
        Thu, 10 Dec 2020 08:04:20 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id k1sm9968055wrp.23.2020.12.10.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:04:19 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:02:14 +0100
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
Message-ID: <20201210160214.GG264602@cmpxchg.org>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-2-songmuchun@bytedance.com>
 <20201210160045.GF264602@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160045.GF264602@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 10, 2020 at 05:00:47PM +0100, Johannes Weiner wrote:
> On Sun, Dec 06, 2020 at 06:14:40PM +0800, Muchun Song wrote:
> > The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> > by one rather than nr_pages.
> 
> This is a real bug, thanks for catching it.
> 
> However, your patch changes the user-visible output of /proc/vmstat!
> 
> NR_ANON_THPS isn't just used by memcg, it's a generic accounting item
> of the memory subsystem. See this from the Fixes:-patch:
> 
> -                       __inc_node_page_state(page, NR_ANON_THPS);
> +                       __inc_lruvec_page_state(page, NR_ANON_THPS);
> 
> While we've considered /proc/vmstat less official than other files
> like meminfo, and have in the past freely added and removed items,
> changing the unit of an existing one is not going to work.

Argh, I hit send instead of cancel after noticing that I misread your
patch completely. Scratch what I wrote above.
