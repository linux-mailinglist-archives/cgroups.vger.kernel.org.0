Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF52FBD16
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbhASQ7j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 11:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389232AbhASQ7Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 11:59:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6331C061575
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:58:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d15so8741147qtw.12
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZrHO+yIyrdnmaVFMwMvHwDYxfdcxIe8NtcCENOohqSk=;
        b=IjO3yV9X3nKmpNx8G+WcMwGh4WEgM94OpZUe3C4BCxS9AKRrGEhbWZO7OTjbH7Ne3x
         hBn/tqmq9p/SRMGTavW8121ebd0zIeiAp/LuvwT6FMfCYkBE04QBVr87DOd2YF1dJ5XU
         VGAQcehIYy7JkkebnKqVX9kRX0Qn0F76T8Y/cDI+QGt0gljuxp0EF85EX96ntV+03wOk
         7KbKWoG2E/FhQykR4/gb9nAj7FAsU+Ia39sjuA/EFf/99riTedyctkT0L4TZQXUZwWmk
         JAQBPrNevBWhtXC2xw3srAkrdbawiF+K0gCtNuEOPdxq0l1YTimU5KpCR879RCLBNVad
         7RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrHO+yIyrdnmaVFMwMvHwDYxfdcxIe8NtcCENOohqSk=;
        b=YKFRWeVjuvrLQeEypTP7t60FMT3iBJgtV+zael7qBfV4aSlG+HgeuyYXai4ek4u475
         WwygEYJmBoPK+QV8vyMJHC4lvwlIgHUyt2G5DQhawCf12zbYhMLavDSmcn6HChJ1jm8+
         2BuEyxX2GHwRbe+/8n1VZrR5CnD4h9D1px+JL37NwKRZfSAgzfBVfhE4tHW5/Qf620iv
         XA4Jx/W6RPsUODFzsYJ7hj7s7ZVP/m/PvqMWv3pxcq0dyg3ZK1wxJhLzgT89k83O7FL1
         GCrUGBy0pihuapDI20RwZZWHgwC6o+o+8MAjhaPuKJQSycK7jHghw8+cSDP96s9Syg2S
         YCmQ==
X-Gm-Message-State: AOAM530J+UJQAKfoeg1Q2NEjUwHvXg1QyZcnMHAIlxdWXqbxEY3hPWPL
        TpKqjp6b2evdUNRTIfKaRrIa89mZzFBBMg==
X-Google-Smtp-Source: ABdhPJzsyWLPgohCl7XB5LwIp8dV/Pk3lXKhNGMeii0fsyJDhxQqGVWDod3V+nlOOW8bx/cWiERhNg==
X-Received: by 2002:a05:622a:28d:: with SMTP id z13mr5136519qtw.87.1611075523954;
        Tue, 19 Jan 2021 08:58:43 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id m21sm8279408qtq.52.2021.01.19.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:58:43 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:58:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: skip propagate percpu vmstat values to
 current memcg
Message-ID: <YAcPwhl//jF/WpHu@cmpxchg.org>
References: <20210119052744.96765-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119052744.96765-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 19, 2021 at 01:27:44PM +0800, Muchun Song wrote:
> The current memcg will be freed soon, so updating it's vmstat and
> vmevent values is pointless. Just skip updating it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Oof, that's pretty subtle! Somebody trying to refactor that code for
other purposes may not immediately notice that optimization and add
potentially tedious bugs.

How much does this save? Cgroup creation and deletion isn't really
considered a hot path. It takes global locks and such...
