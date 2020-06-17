Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352881FD187
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQQGb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 12:06:31 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44822 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFQQGa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 12:06:30 -0400
Received: by mail-ej1-f65.google.com with SMTP id gl26so2918786ejb.11;
        Wed, 17 Jun 2020 09:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tlbxG54rgd+6fqV6RAW61FEmri3bgkhNHXx9gI+QO08=;
        b=jb16FbQVFpFEpuyqs/N22alEgPwD8x9ngTuRZ0vTRYYthZqmFk3V7LoVQ2wj9AkjlF
         J2JXtJG0NfWhxIZzNulG008V2/eAYR5Z7AEaLbZc+hCNbGa+66gI5I2lLRnmbz8VQe4y
         mNN2U/EeslehTuMbG464S57WoSSt8hPHA/yg5LNAVOdzPgKrR4WvbPhjiUjLUqFi3DAf
         5aN1UO3M0SFAsjZMRyyZPCDl2zCZ6HSByHVsIrPI62j2ruOZRqRu6HqEtItCV9csBzI6
         +Otk4KpUCr011snxsdVvHNpefAIlqoD2qvds7b0ewCSDPnhh4CwyATc4dajf+Sjxzp4M
         g8Ow==
X-Gm-Message-State: AOAM530gKbqJj/uHcWAZXcXH69lQ3PxM477ZJ6SyO2WEtEg9vR2CeD4L
        7aZA2kR6eMAVmVh/GEbnoEIR2KWx
X-Google-Smtp-Source: ABdhPJyTNwsKkxV+Do4IZBMmhJD8BUFelJmhG68Wk1D+d/Hsq8QURbAiEkw9lH4smi6/Pd/IOgjrnQ==
X-Received: by 2002:a17:906:d0d7:: with SMTP id bq23mr8491327ejb.259.1592409987418;
        Wed, 17 Jun 2020 09:06:27 -0700 (PDT)
Received: from localhost (ip-37-188-158-19.eurotel.cz. [37.188.158.19])
        by smtp.gmail.com with ESMTPSA id yw17sm276521ejb.83.2020.06.17.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:06:26 -0700 (PDT)
Date:   Wed, 17 Jun 2020 18:06:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200617160624.GS9499@dhcp22.suse.cz>
References: <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 17-06-20 21:23:05, Naresh Kamboju wrote:
> On Wed, 17 Jun 2020 at 19:41, Michal Hocko <mhocko@kernel.org> wrote:
> >
> > [Our emails have crossed]
> >
> > On Wed 17-06-20 14:57:58, Chris Down wrote:
> > > Naresh Kamboju writes:
> > > > mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
> > > > mke2fs 1.43.8 (1-Jan-2018)
> > > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > > Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
> > > > Superblock backups stored on blocks:
> > > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > > 102400000, 214990848
> > > > Allocating group tables:    0/7453 done
> > > > Writing inode tables:    0/7453 done
> > > > Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
> > > > [   51.845304] under min:0 emin:0
> > > > [   51.848738] under min:0 emin:0
> > > > [   51.858147] under min:0 emin:0
> > > > [   51.861333] under min:0 emin:0
> > > > [   51.862034] under min:0 emin:0
> > > > [   51.862442] under min:0 emin:0
> > > > [   51.862763] under min:0 emin:0
> > >
> > > Thanks, this helps a lot. Somehow we're entering mem_cgroup_below_min even
> > > when min/emin is 0 (which should indeed be the case if you haven't set them
> > > in the hierarchy).
> > >
> > > My guess is that page_counter_read(&memcg->memory) is 0, which means
> > > mem_cgroup_below_min will return 1.
> >
> > Yes this is the case because this is likely the root memcg which skips
> > all charges.
> >
> > > However, I don't know for sure why that should then result in the OOM killer
> > > coming along. My guess is that since this memcg has 0 pages to scan anyway,
> > > we enter premature OOM under some conditions. I don't know why we wouldn't
> > > have hit that with the old version of mem_cgroup_protected that returned
> > > MEMCG_PROT_* members, though.
> >
> > Not really. There is likely no other memcg to reclaim from and assuming
> > min limit protection will result in no reclaimable memory and thus the
> > OOM killer.
> >
> > > Can you please try the patch with the `>=` checks in mem_cgroup_below_min
> > > and mem_cgroup_below_low changed to `>`? If that fixes it, then that gives a
> > > strong hint about what's going on here.
> >
> > This would work but I believe an explicit check for the root memcg would
> > be easier to spot the reasoning.
> 
> May I request you to send debugging or proposed fix patches here.
> I am happy to do more testing.

Sure, here is the diff to test.

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c74a8f2323f1..6b5a31672fbe 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -392,6 +392,13 @@ static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
 	if (mem_cgroup_disabled())
 		return false;
 
+	/*
+	 * Root memcg doesn't account charges and doesn't support
+	 * protection
+	 */
+	if (mem_cgroup_is_root(memcg))
+		return false;
+
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
@@ -401,6 +408,13 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	if (mem_cgroup_disabled())
 		return false;
 
+	/*
+	 * Root memcg doesn't account charges and doesn't support
+	 * protection
+	 */
+	if (mem_cgroup_is_root(memcg))
+		return false;
+
 	return READ_ONCE(memcg->memory.emin) >=
 		page_counter_read(&memcg->memory);
 }
-- 
Michal Hocko
SUSE Labs
