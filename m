Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC02CDBB
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfE1RiV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:38:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41595 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1RiU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:38:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so5123407lfa.8;
        Tue, 28 May 2019 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r8PmQcft5RJ51eoZR31WNho/xyilsVu7uCLR1yi4QeM=;
        b=JT4C1GZ5u716MuG38oMA8m4kjqZNa8qKH9ij5bmN31mD37QnGs2q/DkpLNNQT54Zah
         rUr1i5yoLx+yn8qZ9Z6/k+NXbn69dEk4UXskpJRCo4dqFVYZi1Gp9O+oNSmX7wtFtmTW
         i41ZJ+O6WEW+B/XteUFnOgI6Ny+omV83U8+9UxpLp7+YOX51rxGfMYlVkqNg9scqKNfI
         WJIUBk6E9hEM4Vz1E/YKBi102DMg1BYgG9OCd3G59CHXnh2xpEjE3S386PD07hkNTX/E
         2OeALMR2jlduzQUdutJqLwqHpL4y34Re7iAU4oyso+lxa2BJz+GZ5rAHJg7MSOyUyYXg
         XYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r8PmQcft5RJ51eoZR31WNho/xyilsVu7uCLR1yi4QeM=;
        b=Iw8YZnEhuHQD2GIAJ7a5oi2IArKq4+4SaDkv74T8fNo60TTZ6ur11/lRRktSpAcoqo
         B0tIWPt03OYaypvtFxDl8+qwhSbaYhAq6yJgey6/k7oB4sHCIVpn+M1X61RGBR7YBjLe
         luBPlLC/rdHxthbASplrN0pkncOTTxMN9lIDatdQDXtqtsUYRmos+J7jbS4dtxqJ3gxp
         N4LDhejlCRivX9DeXwKOctfDbOXuwWy8Pf17wt5kXv0ASYKKmWu23KBoeO/vNQ/MD84W
         lq8cKwEQHfH0gGmgdQI1XBkhZg2Pl8ZvKvs9MzfhqAaHAV4rQ0miP2qPTECUGRgnevbs
         NUpA==
X-Gm-Message-State: APjAAAXtRIR9HKS3hp/FKHbbH6peosqLpbPqHhkXAUTV1L4LONBcodX/
        dsPhPijB7SepIthZiMMnPqs=
X-Google-Smtp-Source: APXvYqwduzggJa3CuKgzzvG/ZBPz7SyrVxU3HSrA2hFtyUmdW0XFIf6xWdZSBNqyarXqgVcEOsgxzQ==
X-Received: by 2002:a19:2981:: with SMTP id p123mr11785310lfp.190.1559065098989;
        Tue, 28 May 2019 10:38:18 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id q124sm3003230ljq.75.2019.05.28.10.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:38:18 -0700 (PDT)
Date:   Tue, 28 May 2019 20:38:16 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 7/7] mm: fix /proc/kpagecgroup interface for slab pages
Message-ID: <20190528173815.2km65nchedfumslt@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-8-guro@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 01:07:35PM -0700, Roman Gushchin wrote:
> Switching to an indirect scheme of getting mem_cgroup pointer for
> !root slab pages broke /proc/kpagecgroup interface for them.
> 
> Let's fix it by learning page_cgroup_ino() how to get memcg
> pointer for slab pages.
> 
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c  |  5 ++++-
>  mm/slab.h        | 25 +++++++++++++++++++++++++
>  mm/slab_common.c |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)

What about mem_cgroup_from_kmem, see mm/list_lru.c?
Shouldn't we fix it, too?
