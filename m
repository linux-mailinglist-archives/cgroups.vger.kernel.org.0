Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7C29941C
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788125AbgJZRmM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 13:42:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37121 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788121AbgJZRmM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 13:42:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id z6so9166302qkz.4
        for <cgroups@vger.kernel.org>; Mon, 26 Oct 2020 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=djs/CW12V4A+rnL8mVXSs9xI/UkOfc/xmnw7+ByJ/eM=;
        b=SZXO+BBXdNcrW74AgUZzt6jyzJoA0LDHbnm9Q60LBwKaRuIS5DDT8EMMIBQ+8v7ybm
         4NMxPkr7hkQW92+yQF9eagujlyehAYXlus7xlj6hPQLSQMeQSussoqkFMviC/T+HpnMm
         PQVFhtfBESS3t56Pa4XiIY40M5syaVbQxiTdqrx9SAtQ/I/sCUqe8ViQ+SkdoWu4qwLa
         eYJSCZCWZ20Op3LGAmbWZJRfgCp8qlGS/L6t+v+KvllIPjm/p2Y6TgAzRSkbQnKw8b8d
         Nm0NAwFXkKwMQDJRD0S5jyFk+bq/xrZlSbypj0dEbQ+PamTzXpqJBSrL9GtX5iXwqkXG
         VXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=djs/CW12V4A+rnL8mVXSs9xI/UkOfc/xmnw7+ByJ/eM=;
        b=Hi1JVt8b/wzq2YaESFNUu/L9zFGOS5IhvvKb5x3qua6RNpic2Q52BOyn8Hh8iqNrUC
         x0o+G3+6dP/1u+STOQNA+uFfgbFX34gErC1HXp0UOaGjfS5or4U4iOxgmj2OBUiyUaAM
         fiT0eKIfJprFbl+5W2rJafhPk5SxBhVZixBLQTc9XGOBQ934qXx4vEVBlf5r/P4a1R8A
         ++QKSs2bS61DkmO3l3rsgxe5qNT65S5wt/q7V8H6awJ7wBqrltfbjHVkScIKGgbP6mFo
         JuTZ6U1yIDELVy0N9D0NoxkovCl6hmmONU1gosT8H2FbATp65Syhk5o7/2UZI8ORb5rR
         dgGw==
X-Gm-Message-State: AOAM533m3EEzhHR8ujOGQg9LeFoxVXmRH0b86+rTgcyAB9tpU7KEjxyL
        e1G2U5mh7RLIBhPO5s4oFQPExw==
X-Google-Smtp-Source: ABdhPJxViE3Khdgsx+mFRa6liQS80fJavRD5coCwgftZWOxLPZd9JijEsw3zwZkY+LwKsAih02pUyw==
X-Received: by 2002:a05:620a:4f8:: with SMTP id b24mr16409908qkh.299.1603734130621;
        Mon, 26 Oct 2020 10:42:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be5c])
        by smtp.gmail.com with ESMTPSA id m12sm4266811qtu.52.2020.10.26.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:42:09 -0700 (PDT)
Date:   Mon, 26 Oct 2020 13:40:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Message-ID: <20201026174029.GC548555@cmpxchg.org>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
 <20201025113725.b60f2b08d7331a31edf009a1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025113725.b60f2b08d7331a31edf009a1@linux-foundation.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Oct 25, 2020 at 11:37:25AM -0700, Andrew Morton wrote:
> On Thu, 22 Oct 2020 11:18:44 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > As huge page usage in the page cache and for shmem files proliferates
> > in our production environment, the performance monitoring team has
> > asked for per-cgroup stats on those pages.
> > 
> > We already track and export anon_thp per cgroup. We already track file
> > THP and shmem THP per node, so making them per-cgroup is only a matter
> > of switching from node to lruvec counters. All callsites are in places
> > where the pages are charged and locked, so page->memcg is stable.
> > 
> > ...
> >
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1507,6 +1507,8 @@ static struct memory_stat memory_stats[] = {
> >  	 * constant(e.g. powerpc).
> >  	 */
> >  	{ "anon_thp", 0, NR_ANON_THPS },
> > +	{ "file_thp", 0, NR_FILE_THPS },
> > +	{ "shmem_thp", 0, NR_SHMEM_THPS },
> 
> Documentation/admin-guide/cgroup-v2.rst is owed an update?

Ah yes. This?

From 310c3e1714e1c093d4cd26dff38326fc348cdd31 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 26 Oct 2020 13:39:19 -0400
Subject: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat fix

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 608d7c279396..515bb13084a0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1300,6 +1300,14 @@ PAGE_SIZE multiple when read back.
 		Amount of memory used in anonymous mappings backed by
 		transparent hugepages
 
+	  file_thp
+		Amount of cached filesystem data backed by transparent
+		hugepages
+
+	  shmem_thp
+		Amount of shm, tmpfs, shared anonymous mmap()s backed by
+		transparent hugepages
+
 	  inactive_anon, active_anon, inactive_file, active_file, unevictable
 		Amount of memory, swap-backed and filesystem-backed,
 		on the internal memory management lists used by the
-- 
2.29.0

