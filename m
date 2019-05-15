Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32361F61F
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfEOOAK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 May 2019 10:00:10 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:43512 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfEOOAK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 May 2019 10:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1557928809;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=4ieRb2nYTufrIwfIxuW2F44/d/JKF6r4h/5BZmbEcuI=;
        b=GPh6v1G7tBjvpfFjo9hMZCwciiN03v/sot2b6JO2p5YHO8lXYBnhnIAa773fVXRu
        NGiplz1lNIFeTYhBR7fj8DXMn08uMJgxeOHgROgOZJOZJdlyx8cjerUOr72NjVKKNYE
        reEPlVqpmXBv9O4oVqSDSIIrIfo8rpP9+X97ikkw=
Date:   Wed, 15 May 2019 14:00:09 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle
 management
In-Reply-To: <20190514213940.2405198-6-guro@fb.com>
Message-ID: <0100016abbcb13b1-a1f70846-1d8c-4212-8e74-2b9be8c32ce7-000000@email.amazonses.com>
References: <20190514213940.2405198-1-guro@fb.com> <20190514213940.2405198-6-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.05.15-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 May 2019, Roman Gushchin wrote:

> To make this possible we need to introduce a new percpu refcounter
> for non-root kmem_caches. The counter is initialized to the percpu
> mode, and is switched to atomic mode after deactivation, so we never
> shutdown an active cache. The counter is bumped for every charged page
> and also for every running allocation. So the kmem_cache can't
> be released unless all allocations complete.

Increase refcounts during each allocation? Looks to be quite heavy
processing.
