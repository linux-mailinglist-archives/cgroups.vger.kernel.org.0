Return-Path: <cgroups+bounces-14477-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLgjIQr1oWkwxgQAu9opvQ
	(envelope-from <cgroups+bounces-14477-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:48:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F01BD11D
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F5FB3054DF7
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756C46AEEC;
	Fri, 27 Feb 2026 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnyBZFxd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C4466B5E
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221543; cv=none; b=aKPmxGIlfrvIJFIlg9E2T1EvwXg2vbTVDghsKvz8QSE+CINIJ5TyTCszYj6qOKlQ28SHU4bMtXuTWpys4SA47VbVOoHZwtIlqw4t3fmdu6443JbDkn+40LNUrsSA1pHjJj95L6j5rTsqdkTHXJMMmPK8DU+LGKjef86FWZZfs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221543; c=relaxed/simple;
	bh=MsWV/6FClpkzicCm3xQ7Mz+UW79J9g21c9dx03dFvhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiUOzf+zdOJS0R2d/7mXSA5Q70gqcBq93RoNIcB75iOS3NJuUGe8OjkmZ8I7tNBNZc8hIDhe9RHFB3hDFsgsHFKjL7MssJ+S7IduNUCE4yhI6VpRT2GI/XgeHsw13V/tLt9dgR4oskrDA9K6hVhkK7AMDsh8e6sXdIPcjr5sPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnyBZFxd; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-679efb9eb0dso1812709eaf.2
        for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772221541; x=1772826341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jbxq4nQ7cCHo0K9mO13qBbib2DHZAL310WhuqAgZmw=;
        b=GnyBZFxdp33FpzAr3ouCwsr97jlH1Vte+VfbQ633QrQaM6ux9/CuISbnmnu7DrFCki
         66HyogM0m6iEfuvCp+2Bps+rkRklfgHGo+PR34I7sUEZI9ucbJFr26CZNK8zp2ymIzc9
         31QHsQx1SI57zQ0//39jdRMnLQ/K87OPSm8i4nef3/gYDAP456weB6DLGuf0JXBay7Tq
         +WQmp0MwBKP6MTXCG6yuWR8ta8LZg1KnkFXSnBhGPi6+ZZHDn6+2Pre7To/SaD6IjilF
         wLs9bipO6sYAOIY9+dts7zyceJzQ8Vsx+ncvRPLz5B6A66lfquVdu+stZ1eV+nxwZa2X
         LwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772221541; x=1772826341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Jbxq4nQ7cCHo0K9mO13qBbib2DHZAL310WhuqAgZmw=;
        b=vmgfMVlubCQqdi96XEKdFJFWJ0mJ5srmNHJYAm9D4amHai+TyhGLsBnrE47m1Lx0aU
         PEEWCtE5V4cty5rnlhRMn7EHy0Zozr/uOwUuAsfv2Rp4gqv0BeQzE8m8OKalWssVMm0v
         grLxNZkhUpW1ciJ0VaWo/eO/7HQju8dYhO/izbLhGfe/PoemTZ+2YLFB1rqDqsxn37oq
         jnOXi60mzE5fzQ2x4T3P5nV1dkNZzHEC+FuR2yVjN6CsL2bQIlDiunU8z4IjvzxPRYMl
         4WUCcfBBjdMzCcOkZ92+Ra7fmhAxqju22FXRJaBd337DOxhkAu7+bT9brXChthKfuLEo
         3mNg==
X-Forwarded-Encrypted: i=1; AJvYcCUmU4y1U72yTvw6o9EM/6Q90U13JmtaFp+3LCtcwxKZZe2Lu5fyKctwM/gfCZRCR6tLpSZgmXkX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4zNhrktV/e3mW3fd8iV7h5IYn/eQQRXxk9/viPc5TNvzfkXY
	zyyGoAWttk/dgWGTpxyxq+b2VupYDQOwlD+9IEQHi0G/E2DuUy3mDBEC
X-Gm-Gg: ATEYQzzz5nM083U475R7EfSyjenVDIevxnlyurYokGHCYHPvYtPoyddD/1boG1UCt5A
	KueePX9eIrlNw3RrdbRn35lgwSt2wUP/fl6WtHZzcKeQSB+EtsSYRJrl59t79PCKXF2+afoYOWN
	0l0s3Z5ff37wfj4U0TyCCsCFxwKwOtBYVP9LiXaBycfQn+8ldLcqiHZPthI0o97nagTKuwcWGXf
	x1vTua2eOy5bpvZ95VRXqcC8AJcO8CuBdMXtcfcoNwszz2H1Rokk6AuA6s6pp5I/NLtus1sXxYQ
	qkxGmv7+JVuoI2vf3zneII0Qf4qu3DL7LTFq3lKLvs49BAQaRHFAae5uqLyUtZQRg0RMJnawVxs
	pz2VjJj5ipeUOjEwTH3lSSbT2D6UN3P/O3Cm9xu+efVty3Djz/G2q/cSeIz0pKW5iTwkL0M8qU2
	1yXRGmpga86BDjjwWe5XzHJg==
X-Received: by 2002:a05:6820:8187:b0:679:e7b2:9fc6 with SMTP id 006d021491bc7-679fadc292emr2651719eaf.3.1772221540840;
        Fri, 27 Feb 2026 11:45:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm4162972eaf.7.2026.02.27.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:45:40 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	oe-kbuild-all@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 8/8] mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
Date: Fri, 27 Feb 2026 11:45:38 -0800
Message-ID: <20260227194538.928770-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602270607.dJP65LGH-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14477-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url,intel.com:email,git-scm.com:url]
X-Rspamd-Queue-Id: CF9F01BD11D
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 06:40:18 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Joshua,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on axboe/for-next]
> [also build test ERROR on linus/master v7.0-rc1]
> [cannot apply to akpm-mm/mm-everything next-20260226]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-zsmalloc-Rename-zs_object_copy-to-zs_obj_copy/20260227-033239
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
> patch link:    https://lore.kernel.org/r/20260226192936.3190275-9-joshua.hahnjy%40gmail.com
> patch subject: [PATCH 8/8] mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
> config: powerpc64-randconfig-r072-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270607.dJP65LGH-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> smatch version: v0.5.0-8994-gd50c5a4c
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270607.dJP65LGH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602270607.dJP65LGH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/zsmalloc.c:813:17: error: call to undeclared function 'zpdesc_objcgs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      813 |         bool objcg = !!zpdesc_objcgs(zspage->first_zpdesc);
>          |                        ^
>    1 error generated.

Hi Kernel test robot,

Thanks again, this seems like the same problem of not defining
zpdesc_objcgs outside for the !ifdef CONFIG_MEMCG case. However, in this
case I think the change that needs to be made is actually to make the
charging happen unconditionally, and within the charging functions
check if objcg is present, since the node states can be updated even
without the concept of a memcg.

Thanks again!
Joshua

