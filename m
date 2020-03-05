Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397B217ACDF
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 18:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCERW4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 12:22:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40527 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCERW4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 12:22:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so2905045plp.7
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fYgwNPn+hzRISUrcnyS4RtnmnpZ3Kb0VaVci8GbrKTU=;
        b=o3YE+cY0AMvX9FIW61axswC5hLklVI8JTAIAQgcBVazuzotTqc/h+Pg/g6abfRuyzX
         4tXglOcKGcpc3Vagoluun7pQ18V4NCAMAXN4KVIey9I3n/1BsqLmzHVTuYyPZDoMVbS9
         GO/1VbUKbSM4tglRQh3iDgaRKj9fi/5oH2waIvdNhUu7AFyImdXwXpx21mwDy2i4i583
         gsNE50sIgAG7q8VTCuKUIRa9C0XTWAXjU/lPN0+zsdp6Mhxfvpxo9x0ciDBWiSofPoLW
         XYl/9twPKE5N9aeDYfS3VDDx0eVriYJZRqtpPPdiX7+DsxzXzILz+SDuaSXU9Xn3dwjf
         PB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fYgwNPn+hzRISUrcnyS4RtnmnpZ3Kb0VaVci8GbrKTU=;
        b=ilQYy/C7bD9r6fQnsnWaEnsfiLwZj/FtmZ+N1J7fwk2Zwfhj6Lhl1KR2zKLye3IR3E
         nFkWVO87j1cybNF6KdtUM2l2CvqQ4Gc/Tc8HtoxsjWLqxyvRZdBR75T8LOI6T/y4kRUE
         ZyoDwTCdS5UxhW/SIU/Ua9ThYTSDBW0wWZa6sNCtFJGHkaTlOMPI+15WkDAU96DoAYFE
         JaG8ZN2hmWcsT5/CLtTcZaDhEO1H7G9T4R40iaeueyXzfToNJXfq6Yv2ZimroQOj0EvC
         NJQalZ4fuSvfxQmiUR6yXgcOq66oJT1wgEz2a36aOkkEw38d8I7m2GBtDMtWSL8rKBXM
         t1JA==
X-Gm-Message-State: ANhLgQ0W26gXOqGDfFpcf6rpoeKWNDk9oJRTAV51RlhsFJDrtAp9I2aS
        SAzQKqlLj/2XdNOzq2Ji18NvvPhuEr8Pqg==
X-Google-Smtp-Source: ADFU+vu5hq4I0Ryc8m9cr+fBrdw4pFYXc4hKs8nOlBf+e8bunC7kkHnRLwz1LIohkT6ORGzit+5H6g==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr10057159pjq.47.1583428974706;
        Thu, 05 Mar 2020 09:22:54 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:6216])
        by smtp.gmail.com with ESMTPSA id 9sm28532487pge.65.2020.03.05.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:22:53 -0800 (PST)
Date:   Thu, 5 Mar 2020 12:22:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Make mem_cgroup_id_get_many() __maybe_unused
Message-ID: <20200305172248.GB2508@cmpxchg.org>
References: <20200305164354.48147-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305164354.48147-1-vincenzo.frascino@arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 05, 2020 at 04:43:54PM +0000, Vincenzo Frascino wrote:
> mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
> configuration options are enabled. Having them disabled triggers the
> following warning at compile time:
> 
> linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
> but not used [-Wunused-function]
>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
>  int n)
> 
> Make mem_cgroup_id_get_many() __maybe_unused to address the issue.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Vincenzo.
