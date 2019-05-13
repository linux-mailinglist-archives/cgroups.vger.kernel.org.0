Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917911BC85
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfEMSBG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 14:01:06 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:49352 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727668AbfEMSBG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 14:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1557770465;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=PlYvmqxRpVISnjsRFpBbrKcWou6q8G660sOR1uIfQB8=;
        b=b8UGgDxXFtgOe6/nHEgwLitQKKdP6MaTm72eml72TE9fnqIiPmXw8fT7pLun0Kck
        rTcHdXuzgkeKJJQmYht5nMnPLcckFMsU/bqzVWYwIlrnDkBQuekNUTWLhxi0ugBfjUe
        6vhOsZoNl7l4/KTlnny/6ogqiyJ4zFkjdnQwfoKQ=
Date:   Mon, 13 May 2019 18:01:05 +0000
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
Subject: Re: [PATCH v3 4/7] mm: unify SLAB and SLUB page accounting
In-Reply-To: <20190508202458.550808-5-guro@fb.com>
Message-ID: <0100016ab25aef20-4552213a-13e1-4aff-ba52-e970f3ac7fd4-000000@email.amazonses.com>
References: <20190508202458.550808-1-guro@fb.com> <20190508202458.550808-5-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.05.13-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 8 May 2019, Roman Gushchin wrote:

> Currently the page accounting code is duplicated in SLAB and SLUB
> internals. Let's move it into new (un)charge_slab_page helpers
> in the slab_common.c file. These helpers will be responsible
> for statistics (global and memcg-aware) and memcg charging.
> So they are replacing direct memcg_(un)charge_slab() calls.

Looks good.

Acked-by: Christoph Lameter <cl@linux.com>
