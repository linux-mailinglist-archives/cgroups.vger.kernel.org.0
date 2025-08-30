Return-Path: <cgroups+bounces-9515-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FC9B3CB44
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AC217BAB1
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BE231A23;
	Sat, 30 Aug 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="H5vtm2ee"
X-Original-To: cgroups@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA958228CB8
	for <cgroups@vger.kernel.org>; Sat, 30 Aug 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560641; cv=none; b=VpckcE4ecz+b6NCqlH5jvuouWuKbLiG5u3FsZSfum86G8GuRGnG5NM7ARYfkcfhP/Yn2/ujVs1H2M4s7Eo/hlSe1PAJkTH7a2v5FsHapbvv8a3XMjZ1eyUKqzFdx6ocq8PE24SHQ6g67HUQpMYqkv9sPYm1TK2IxHv4EJHIz51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560641; c=relaxed/simple;
	bh=js4jRuGtIjXoxTl7Rm8nWKGpVH9t6HuHYTUgGIeBVw0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aUMuE9TH5URmMNN/3UeawQOMxJvnZn6Z2/FEae60uR1Tm8qkDXaCRj3W+jjiAEzBfLU/9S+bxpnDP2M/kKjSpEEOdk1RvL9a1KAfxN14nZnlM8j5rSDfkWWxg6Am/N0QBbT+IpwcCF0+NnMzmmZRY9LT3aNkwhnf2KCP1njBAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=H5vtm2ee; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id sGVIuudi1v724sLf7uoZcT; Sat, 30 Aug 2025 13:30:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id sLf6ugAlUQb4IsLf7uI2RP; Sat, 30 Aug 2025 13:30:33 +0000
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68b2fcf9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4BrsA8FZ1ibyw0l2C7AaSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Tlvygc7yRPAoqQeoTmMA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:Subject
	:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kb6IMCa6AiTu5VW83JaOqtM5LfmQWxQuu2DNHKdLMIE=; b=H5vtm2eeYlCt6oHwFKgfwKirT9
	ZIJcZ3IDJYwsot3sZM1r4VFNoAzftaC1s+gvRMGzVthICEOx563pPXNVXRlSOsxccrPrT0QdgRTRJ
	U7cKkuqfDMgbgkqL4AVDTr7aNmEAfuBzUQ3kSqRLNE0tZd1Q3p12jnpzwo2/7KyVvJvMA8Z5fTxPs
	w/gkbwkZzFB3VMgDo9i1k7X1qnZXqPy65BCg25GdJrAEAmuAXmsNZ1CWm5MHRlaTWmb3eV930PpQB
	bG03klq9fPyXcP26xy+PN5iNUS5/OmvhtktkGTXlhzbFMZtAhDtqLgKdHEkz9MyQYEz0alKCeYY1t
	lO8/deVQ==;
Received: from [185.194.184.202] (port=4144 helo=[10.233.40.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1usLf5-00000003wxI-241K;
	Sat, 30 Aug 2025 08:30:32 -0500
Message-ID: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
Date: Sat, 30 Aug 2025 15:30:11 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.194.184.202
X-Source-L: No
X-Exim-ID: 1usLf5-00000003wxI-241K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.233.40.44]) [185.194.184.202]:4144
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKkFG/Ar4E3EW9tEVKIF+YcP/gwJuDWkA63gZUILFDS/YK/HS32kBGPMMZI6uhBYMfcbvrbPG2Id6P/4PZurTCAJ3LKSAIpDJuMw1Obc3VTBBKpEEnfD
 P5JFrOx0wrnDSx75rF60zZU6QDhCHXPe8JgU5701YxBb3MW2H7coeOFMbHUZiJyi06nH4q+WZGoXz4snQ4I8KpAA690uq/xawYc=

Hi all,

I'm working on enabling -Wflex-array-member-not-at-end in mainline, and
I ran into thousands (yes, 14722 to be precise) of these warnings caused
by an instance of `struct cgroup` in the middle of `struct cgroup_root`.
See below:

620 struct cgroup_root {
	...
633         /*
634          * The root cgroup. The containing cgroup_root will be destroyed on its
635          * release. cgrp->ancestors[0] will be used overflowing into the
636          * following field. cgrp_ancestor_storage must immediately follow.
637          */
638         struct cgroup cgrp;
639
640         /* must follow cgrp for cgrp->ancestors[0], see above */
641         struct cgroup *cgrp_ancestor_storage;
	...
};

Based on the comments above, it seems that the original code was expecting
cgrp->ancestors[0] and cgrp_ancestor_storage to share the same addres in
memory.

However when I take a look at the pahole output, I see that these two members
are actually misaligned by 56 bytes. See below:

struct cgroup_root {
	...

	/* --- cacheline 1 boundary (64 bytes) --- */
	struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  2112 */

	/* XXX last struct has 56 bytes of padding */

	/* --- cacheline 34 boundary (2176 bytes) --- */
	struct cgroup *            cgrp_ancestor_storage; /*  2176     8 */

	...

	/* size: 6400, cachelines: 100, members: 11 */
	/* sum members: 6336, holes: 1, sum holes: 16 */
	/* padding: 48 */
	/* paddings: 1, sum paddings: 56 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 16 */
} __attribute__((__aligned__(64)));

This is due to the fact that struct cgroup have some tailing padding after
flexible-array member `ancestors` due to alignment to 64 bytes, see below:

struct cgroup {
	...

	struct cgroup *            ancestors[];          /*  2056     0 */

	/* size: 2112, cachelines: 33, members: 43 */
	/* sum members: 2000, holes: 3, sum holes: 56 */
	/* padding: 56 */
	/* paddings: 2, sum paddings: 8 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(64)));

The offset for `ancestors` is at 2056, but sizeof(struct group) == 2112 due
to the 56 bytes of tailing padding. This looks buggy. (thinkingface)

So, one solution for this is to use the TRAILING_OVERLAP() helper and
move these members at the end of `struct cgroup_root`. With this the
misalignment disappears (together with the 14722 warnings :) ), and now
both cgrp->ancestors[0] and cgrp_ancestor_storage share the same address
in memory. See below:

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 539c64eeef38..901a46f70a02 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -630,16 +630,6 @@ struct cgroup_root {
         struct list_head root_list;
         struct rcu_head rcu;    /* Must be near the top */

-       /*
-        * The root cgroup. The containing cgroup_root will be destroyed on its
-        * release. cgrp->ancestors[0] will be used overflowing into the
-        * following field. cgrp_ancestor_storage must immediately follow.
-        */
-       struct cgroup cgrp;
-
-       /* must follow cgrp for cgrp->ancestors[0], see above */
-       struct cgroup *cgrp_ancestor_storage;
-
         /* Number of cgroups in the hierarchy, used only for /proc/cgroups */
         atomic_t nr_cgrps;

@@ -651,6 +641,18 @@ struct cgroup_root {

         /* The name for this hierarchy - may be empty */
         char name[MAX_CGROUP_ROOT_NAMELEN];
+
+       /*
+        * The root cgroup. The containing cgroup_root will be destroyed on its
+        * release. cgrp->ancestors[0] will be used overflowing into the
+        * following field. cgrp_ancestor_storage must immediately follow.
+        *
+        * Must be last --ends in a flexible-array members.
+        */
+       TRAILING_OVERLAP(struct cgroup, cgrp, ancestors,
+               /* must follow cgrp for cgrp->ancestors[0], see above */
+               struct cgroup *cgrp_ancestor_storage;
+       );
  };

However, this causes the size of struct cgroup_root to increase from 6400
bytes to 16384 bytes due to struct cgroup to be aligned to page size 4096
bytes. See below:

struct cgroup_root {
	struct kernfs_root *       kf_root;              /*     0     8 */
	unsigned int               subsys_mask;          /*     8     4 */
	int                        hierarchy_id;         /*    12     4 */
	struct list_head           root_list;            /*    16    16 */
	struct callback_head       rcu __attribute__((__aligned__(8))); /*    32    16 */
	atomic_t                   nr_cgrps;             /*    48     4 */
	unsigned int               flags;                /*    52     4 */
	char                       name[64];             /*    56    64 */
	/* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
	char                       release_agent_path[4096]; /*   120  4096 */

	/* XXX 3976 bytes hole, try to pack */

	/* --- cacheline 128 boundary (8192 bytes) --- */
	union {
		struct cgroup      cgrp __attribute__((__aligned__(4096))); /*  8192  8192 */
		struct {
			unsigned char __offset_to_ancestors[5784]; /*  8192  5784 */
			/* --- cacheline 218 boundary (13952 bytes) was 24 bytes ago --- */
			struct cgroup * cgrp_ancestor_storage; /* 13976     8 */
		};                                       /*  8192  5792 */
	} __attribute__((__aligned__(4096)));            /*  8192  8192 */

	/* size: 16384, cachelines: 256, members: 10 */
	/* sum members: 12408, holes: 1, sum holes: 3976 */
	/* forced alignments: 2, forced holes: 1, sum forced holes: 3976 */
} __attribute__((__aligned__(4096)));

I've tried with the struct_group_tagged()/container_of() technique:

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20250723&id=03da6b0772af1a62778400f26fe57796fe1ebf27

but cgroup_root grows up to 20K in this case.

So, I guess my question here is... what do you think?... (thinkingface)

Thanks!
-Gustavo

