Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB62324572
	for <lists+cgroups@lfdr.de>; Wed, 24 Feb 2021 21:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhBXUmm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Feb 2021 15:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbhBXUmi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Feb 2021 15:42:38 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FDC061574
        for <cgroups@vger.kernel.org>; Wed, 24 Feb 2021 12:41:46 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 204so3541942qke.11
        for <cgroups@vger.kernel.org>; Wed, 24 Feb 2021 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwNM4IQrP65m3pBxQdPq3PIkStWcpBTasxWsf7+C0lo=;
        b=oynA0tAUXRRCGRxkmQGoFtzMRLvf+22xVNOkpXfaZ3ShiECJzsBik78xQsBCe2C7Ey
         uv/GVxd8ChE9O5nHMvqVZBh+PuvvYDYAENDW5HjbHyecOl9ca+i361mperXkFpE/ckHp
         AbJGwXquplMfFHdrnYcGkVAYrgUneo/hCd91ApPj9Fe/mDlLz3fNjPoou6lbl+UPqc26
         LoT5jV/vczsQTsBXcNmR1HX7Xqu3ITA//sVu5lz8AM1TIivwA9pWY1IrRD+of6J0s4lE
         SRKdT2CGdxuUGNRCrXK5YBk4EyH3UAVXqS/agvlVNAUqVFt2Q9cT27TzExcL7mR0aJFt
         je4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwNM4IQrP65m3pBxQdPq3PIkStWcpBTasxWsf7+C0lo=;
        b=ADU9pJPsmO5m83CQILTjIZT5N8JysEw4EsWNpNkFHzN0NKDmszg7dCmCi24faufoGE
         9mLbxsONxW2HzqP9H87InZdsMUM7T1y3cRDc0fAsURMaNZLDNcS/lxtp5W4IAKf6c2Nz
         69AWHgqChE0nSbsoTwwik4f7nSoaklrhxLpWTdP9Eo+KOEtmJcOuCjEGCfQdJgbeEhaB
         AxuDpjNA5T0YHD6c2ic26V5E/gI9R+/INg9hecm0ElunCHBH9g7df6HO6iFFdtlaiZx2
         hEBSXpNqKnMZRUZH3rXnALSbRcADnXpx7Hk4VSOCnyUHxVsCqaU8AvGRXu4ZvRCYkzgI
         AVWw==
X-Gm-Message-State: AOAM531iAAlQHzsTQcM7HVFQ3HhTGTakfncCPjSNYQyHi+Ty3BuDE9cI
        KHk1CtmfC4OsZW0oMWaiuyNSaQ==
X-Google-Smtp-Source: ABdhPJzPS1yWCPSlG7/+kI7/ZUfr3RkdEDSt24AmwG/AErCzG1jrWZb7GS3fFAgUS97mURwqQfPsCw==
X-Received: by 2002:a37:4d09:: with SMTP id a9mr17091263qkb.469.1614199305734;
        Wed, 24 Feb 2021 12:41:45 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id l128sm2315474qkf.68.2021.02.24.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 12:41:45 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:41:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: cleanup root memcg checks
Message-ID: <YDa6CPuLBPwclYp6@cmpxchg.org>
References: <20210223205625.2792891-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223205625.2792891-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 23, 2021 at 12:56:25PM -0800, Shakeel Butt wrote:
> Replace the implicit checking of root memcg with explicit root memcg
> checking i.e. !css->parent with mem_cgroup_is_root().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
