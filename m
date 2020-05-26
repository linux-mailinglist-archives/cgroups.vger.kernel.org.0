Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6672B1E2449
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgEZOmq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgEZOmp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 10:42:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A06C03E96D
        for <cgroups@vger.kernel.org>; Tue, 26 May 2020 07:42:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so20723154qkh.11
        for <cgroups@vger.kernel.org>; Tue, 26 May 2020 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=09NkzIHZAJnaabNzltJNpHqTja29HfRyqZxJgoASsis=;
        b=vI9pk3mv7VAhL8kvPHHXxJTQQGYcJUu5GTZZ6y4YiwW3Y1Avrv5r6XHrvcwie4PK4c
         7KR2HeHdQ626DnC+KI0hNsNedItJfqKaOr0YxxXKy219Pw9WtoVWw4dx+VD68JzvD8Cq
         g8OGFYLtvNGHCUhid3aoNQpxdXhUSSaaFHXRBicYB4SMaqFvgoZ2tej3Y6M3crYF7fkJ
         3gQZ3YZp0OIlp06GtfIqbVaEh+qHRIhcsNntKn7umQzLl594/L67uSCsIjzgYz4a5vWM
         Yld7CRzSE4YOnxonpfPnd+Im85yT+W8HxHx81wzUq7GlVpc/6ZLUlxe3Mr4xtAz41XVn
         mdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09NkzIHZAJnaabNzltJNpHqTja29HfRyqZxJgoASsis=;
        b=DsHDSbfLrlB3Yi/dAIqty+uBNo1sO/z7TDT5smyWbRtWZhUYjigf+WzQG27nTgJYje
         dZYKlvuOk0MFNB1hGRdpEHYCNonFqB3sdJpcE7RR4J1CX7O8gvnrq9AzVFOSnmMnnTEK
         1YoPJCPTssMFFkq+uw5eqkr1/Xu+QUbQz5oa4m1z4/ZBim5nLySe411EBliDgmTIQecc
         eWyvKFiqfoDKEdqAwaUNTo7M+ZNtSynYk/HofktP9ej8Fzilz7r25QWXPdHSh9jdyU9T
         RZpTYGIIrPdkXu3TXAYwzM7FbX/jCo3J5Fb2MfYcZSw9Py4k+n6y09q5/uyO2KfOYC+t
         SM5g==
X-Gm-Message-State: AOAM530UUSbx6L+eDWFla0jOUJxNhFci/1/z3JH++Q9mMTQGdnx+tdpS
        Y/hm7OVnG6PMDzK5jOrIOszsfg==
X-Google-Smtp-Source: ABdhPJwYZKiVL7ZZ4O2XNxuu8qpgaV+gbfp1Bjau1oRMoeNZ1EufXPxllHj6tkd3uo4heu/D9fbuyg==
X-Received: by 2002:a05:620a:2290:: with SMTP id o16mr1717002qkh.205.1590504164622;
        Tue, 26 May 2020 07:42:44 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id j90sm17507683qte.33.2020.05.26.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:42:43 -0700 (PDT)
Date:   Tue, 26 May 2020 10:42:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org
Subject: Re: [PATCH mm v5 RESEND 3/4] mm: move cgroup high memory limit
 setting into struct page_counter
Message-ID: <20200526144220.GC848026@cmpxchg.org>
References: <20200521002411.3963032-1-kuba@kernel.org>
 <20200521002411.3963032-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521002411.3963032-4-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 20, 2020 at 05:24:10PM -0700, Jakub Kicinski wrote:
> High memory limit is currently recorded directly in
> struct mem_cgroup. We are about to add a high limit
> for swap, move the field to struct page_counter and
> add some helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This move is overdue and should make it easier to integrate high
reclaim better into the existing max reclaim flow as well. Thanks!
