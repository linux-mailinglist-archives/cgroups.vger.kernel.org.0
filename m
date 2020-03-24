Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890381919C1
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgCXTRP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 15:17:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44316 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCXTRO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 15:17:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so7803771plr.11
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2020 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rh4HBg/agEMeOOZna2pzZhd8r6lKpuw8m53EKKUPZHc=;
        b=tIMOfdTlHbbOdLWgQGt6oJeQvoMFtQVTFpy2pLi7nTYBlhcgtjoQBFLNrAmUCFix+T
         Wp/wocBxPQTXgY7/RgRBxViOlX3qvt4qAYEk/YW1KHupUy3P9tp2KaMOzrX0R6sTFgf6
         PliVP2qUb/uLXnzP8BjH8l1c4dAaUAh3rFpjd7ig+b66BRc+pgAFmsMRdIB6fEqjczvQ
         yQTmo6/rDRuUJ5/DZl7UmqTf1BXpa/ALNbK4+wuduHiTGxYnqbqiVNJ6K3EZFv9wHg8E
         xLxeTBC5Y9IaRg2G++TFA5LGhvZDI2ZYBb4si3IViJ1w3uXfMxd2yLIR9+XuIcNGFgWl
         9f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rh4HBg/agEMeOOZna2pzZhd8r6lKpuw8m53EKKUPZHc=;
        b=kK9V5zA8525rLYMjgC4Bg716n2KwlnJhJhBLKc2MXimzRGM1zyokzis7CBnYvOJa0W
         2FDYUGXizOcrXQcj7HuZoLhPvEjyX1f4w6tL/oPMHXNXyLGjSYHcSLAUY0tTGS9oY2K4
         qX3awy8phbXs3bRkOu1BA6G2Ro/y2ve0/SGas/MMrrA0iH0TTN9KtE0LHjrXVlixbjtz
         6B+gATlyf42v3Va8K3nT6ImuzHIZorzSsCPQ8CJoUCdLjgedLCU7yhFeSVTC5sdhiwRU
         5d8T8VB2kTQ7qzqWxEoEepiXfrRtmX8aTd8bMhwLZzSHlZI5W4XuXXT46n8UBkI5adJp
         Yc0A==
X-Gm-Message-State: ANhLgQ0SQEWuXFJy6i2rR9j65tlwhVvPbAJJukRZ7QvNAKy3bendChb0
        hGPBbskc05FE6xnmj5VnrHjEFA==
X-Google-Smtp-Source: ADFU+vupg7MB8LHNKMkljbJFFhiE3/MiCNtH+/LIaDpRYt4jhcqCLjd6AEqV1lRYWFM6fJ38Oue/Bw==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr22947183plo.137.1585077433211;
        Tue, 24 Mar 2020 12:17:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k17sm16391918pfp.194.2020.03.24.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:17:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:17:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hui Zhu <teawater@gmail.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, sean.j.christopherson@intel.com,
        thellstrom@vmware.com, guro@fb.com, shakeelb@google.com,
        chris@chrisdown.name, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
In-Reply-To: <20200324121758.paxxthsi2f4hngfa@box>
Message-ID: <alpine.DEB.2.21.2003241215580.34058@chino.kir.corp.google.com>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com> <20200324121758.paxxthsi2f4hngfa@box>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 24 Mar 2020, Kirill A. Shutemov wrote:

> On Tue, Mar 24, 2020 at 06:31:56PM +0800, Hui Zhu wrote:
> > /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
> > control if the application can use THP in system level.
> 
> No. We have prctl(PR_SET_THP_DISABLE) too.
> 

Yeah, I think this is the key point since this can be inherited across 
fork and thus you already have the ability to disable thp for a process 
where you cannot even modify the binary to do MADV_NOHUGEPAGE.
