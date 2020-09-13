Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803F4267D00
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 02:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgIMAmn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Sep 2020 20:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgIMAmm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 12 Sep 2020 20:42:42 -0400
Received: from X1 (unknown [209.33.215.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20972087C;
        Sun, 13 Sep 2020 00:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599957762;
        bh=zWEjpsPiw3tRbjW3SotHs8K4FaJz/c98OlcLD4VZ/Dw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6daZwQC9E45NL2heKtVG8/msTxuibvIJ6YUkqfpGHxV6KdQKOjvb2WwlBnCDDbnP
         paIS6oXa7OSwrOL1GK4t3UQ7V+V4W5dKteT3iN0kfMOuVP2j2uwpHNfeZwJQFBAdyT
         aNQC2h1TvgEYoKNi72Q0OOd/q9XzznkmSAKQVRk4=
Date:   Sat, 12 Sep 2020 17:42:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the buf returned
 by memory_stat_format
Message-Id: <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
In-Reply-To: <20200912155100.25578-1-songmuchun@bytedance.com>
References: <20200912155100.25578-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The memory_stat_format() returns a format string, but the return buf
> may not including the trailing '\0'. So the users may read the buf
> out of bounds.

That sounds serious.  Is a cc:stable appropriate?

