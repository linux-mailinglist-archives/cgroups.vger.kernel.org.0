Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0516015E
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2020 02:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBPBaD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Feb 2020 20:30:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38411 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgBPBaD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 15 Feb 2020 20:30:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so5666428pjz.3
        for <cgroups@vger.kernel.org>; Sat, 15 Feb 2020 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H1J2XGmudHXtmp+DJfVLIIqWxd4GHWG0D55ayu8ofeI=;
        b=gFq89J3C6y2E3dC6eJosGCejVHswqtg68Tow44UbrH2gVrpogK7qFB1KHIIqqUr7bn
         tF6i1gknCrbwVMRuZQ5ME8rn/UmTXJDDfhHRV6pW2PIY5pqan+jFUw+/kb92UAgwLVbj
         T/G17QADHWbAVrR3b1QVTsvF3ed/aWsXDnw5zV2uSZHZk/45sRr34UPnEUrZgMEdy6J6
         YqeWVAyXZWILuihYlGoDPXdNP++ifAKU+tFKpgmi8EBlQR2AX2NbhCSBXI96xRW5tjuA
         ImAmKQCewP/SSbyC0hOD2KKx7/xtU+uyWnFN+4DYSnSZDjveEXzbpjxCsl1eW+3zXMKv
         iahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H1J2XGmudHXtmp+DJfVLIIqWxd4GHWG0D55ayu8ofeI=;
        b=aGW7ErPVBqccJCy+3XhScRbnO4m1fcuuaolFW+ZLiYJdcNN95x5hMAla+TGOh2ser8
         eVXDjXQnVKq/x88MLPGWThlndmLkeuNVIcrgCM0NYXuwNLT5zlBcaMLQxygYOhXgJN/8
         Pv6cJKEHTW2XJxJ+FpXIxq+4eNNvbFGM0jhRsAXB8zwsT/HEkz7ye4tHoliM3Zl5zVSQ
         O/zHtKJ5B5jImpBsJqL4qqHC9dVxSwoMeK3Ov3JunGoScZgNqc16vSjgSsuxQnXW6I6q
         v/+E3UzqGv/NjOSCJx7xwxEre7JcgH5If8BeHawOLywNVDb3VdTqnztKMMaMlV0wMXaj
         D0ig==
X-Gm-Message-State: APjAAAWt+OZ/wIzvtb1DYFu0RDzokZjwEtWOXERVh1Vzkd5LxFs28R6N
        W06m6H0Ngjw0m0O17G6p3zMedQ==
X-Google-Smtp-Source: APXvYqyGFRjjGux2Y1Zo0z/8WLWOp+BzYnoiWnfZ6OCKzLnyPcaJCc5ufv5eAEVQKL1cq60yEjgu4Q==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr9683676ple.226.1581816600814;
        Sat, 15 Feb 2020 17:30:00 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f3sm12207242pga.38.2020.02.15.17.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 17:30:00 -0800 (PST)
Date:   Sat, 15 Feb 2020 17:29:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 7/9] hugetlb: support file_region coalescing again
In-Reply-To: <20200211213128.73302-7-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2002151729470.244463@chino.kir.corp.google.com>
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-7-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 11 Feb 2020, Mina Almasry wrote:

> An earlier patch in this series disabled file_region coalescing in order
> to hang the hugetlb_cgroup uncharge info on the file_region entries.
> 
> This patch re-adds support for coalescing of file_region entries.
> Essentially everytime we add an entry, we call a recursive function that
> tries to coalesce the added region with the regions next to it. The
> worst case call depth for this function is 3: one to coalesce with the
> region next to it, one to coalesce to the region prev, and one to reach
> the base case.
> 
> This is an important performance optimization as private mappings add
> their entries page by page, and we could incur big performance costs for
> large mappings with lots of file_region entries in their resv_map.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: David Rientjes <rientjes@google.com>
