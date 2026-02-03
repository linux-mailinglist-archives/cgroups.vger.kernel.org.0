Return-Path: <cgroups+bounces-13639-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJTJHRn1gWljNAMAu9opvQ
	(envelope-from <cgroups+bounces-13639-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 14:16:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A6D9CBC
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FF430AC53C
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CB34D4E0;
	Tue,  3 Feb 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="N2XJtlU7"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E73168E5
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124092; cv=none; b=nX2pf6r7ldRpsrz7AjM9Re/KnncSP2MOOMLG33tjYg6r3gM+7qXNDyoYCREfQmv1GYUTc9kfmK49q/mnAoJZfBkqnZjqNX3W8YqPQMfJnVaASKCFhyNu62YKowcPGXKbglM4KQqT6UVw+xTIT2h1XDV9pZhXW+HsRscTu7ZILxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124092; c=relaxed/simple;
	bh=Nr1vMizxFDfAXxdKnQddvtWzemGKyTJTA/FK27b4ews=;
	h=Message-Id:To:From:Date:In-Reply-To:Content-Type:Cc:Subject:
	 Mime-Version:References; b=hXL3Uhah5k8wU6LqpzZgKMzlAu/eLLfvBe5oCwaAwoKEDoxmgdavQvujIoZHCL/ZtA6sDAqVQGry2pUgKRWreicxEb3CXBbNaC952fxByybZM1YJptPTsi9cnPTNW/Y9Dd/auxEUm91kiUg6b5qriXE5P74HYIqTa7uYUX7OqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=N2XJtlU7; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770124077;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=WEIc2C7t30KTvso3/M8OaAVTRIx/FHGpTvmNPMADIqM=;
 b=N2XJtlU7VdnTYb+ZeLko5xKK8TzgR4UUlyuMgKSbxg4qTlilGcQWyEHsNYpw4PSgU2MxCr
 IojqkfCjLwFpMgU6kC0Hxw309pRhEiJ/1xbgdm4Bq06RA9tCQkbyQegSnPz5BeF6FLredL
 OaYJ8yadxCd8XKgQ1spRRlgaCKk+27vwhDyg9wJ1ywF1Usx3oZ9+WB0FJ6KZVGZjc7rFed
 5+lvf4DN5RSXHNaPPPdqUg1q3H1mqyOJu+6ZJbyRUmgFotB+p8ht11FLgaCxouGH/kq0pP
 7jSd0oe45tWbwiA/6D4MU62m+IEN6lvpr8wcaYN7Ivzs5nRRzz+4vRwojwEQjg==
Reply-To: yukuai@fnnas.com
Message-Id: <6fa416ae-7fb4-42b4-98e9-1a6a434baf3f@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26981f32b+92768e+vger.kernel.org+yukuai@fnnas.com>
Content-Language: en-US
To: "kernel test robot" <lkp@intel.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Tue, 3 Feb 2026 21:07:52 +0800
In-Reply-To: <202602032018.BRG7c7LT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Tue, 03 Feb 2026 21:07:54 +0800
Cc: <oe-kbuild-all@lists.linux.dev>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<zhengqixing@huawei.com>, <mkoutny@suse.com>, <hch@infradead.org>, 
	<ming.lei@redhat.com>, <nilay@linux.ibm.com>, <yukuai@fnnas.com>
Subject: Re: [PATCH v2 2/7] bfq: protect q->blkg_list iteration in bfq_end_wr_async() with blkcg_mutex
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203080602.726505-3-yukuai@fnnas.com> <202602032018.BRG7c7LT-lkp@intel.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13639-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas.com:mid,fnnas.com:replyto,fnnas-com.20200927.dkim.feishu.cn:dkim,01.org:url,intel.com:email]
X-Rspamd-Queue-Id: D65A6D9CBC
X-Rspamd-Action: no action

Hi,

=E5=9C=A8 2026/2/3 20:54, kernel test robot =E5=86=99=E9=81=93:
> Hi Yu,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe/for-next]
> [also build test ERROR on linus/master v6.19-rc8 next-20260202]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-cgroup=
-protect-q-blkg_list-iteration-in-blkg_destroy_all-with-blkcg_mutex/2026020=
3-161356
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git f=
or-next
> patch link:    https://lore.kernel.org/r/20260203080602.726505-3-yukuai%4=
0fnnas.com
> patch subject: [PATCH v2 2/7] bfq: protect q->blkg_list iteration in bfq_=
end_wr_async() with blkcg_mutex
> config: i386-buildonly-randconfig-002-20260203 (https://download.01.org/0=
day-ci/archive/20260203/202602032018.BRG7c7LT-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260203/202602032018.BRG7c7LT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602032018.BRG7c7LT-lkp=
@intel.com/

Looks like this is due to CONFIG_BLK_CGROUP is disabled, will fix this in t=
he next
version.

>
> All errors (new ones prefixed by >>):
>
>     In file included from include/linux/seqlock.h:19,
>                      from include/linux/mmzone.h:17,
>                      from include/linux/gfp.h:7,
>                      from include/linux/umh.h:4,
>                      from include/linux/kmod.h:9,
>                      from include/linux/module.h:18,
>                      from block/bfq-iosched.c:116:
>     block/bfq-iosched.c: In function 'bfq_end_wr':
>>> block/bfq-iosched.c:2648:32: error: 'struct request_queue' has no membe=
r named 'blkcg_mutex'
>      2648 |         mutex_lock(&bfqd->queue->blkcg_mutex);
>           |                                ^~
>     include/linux/mutex.h:193:44: note: in definition of macro 'mutex_loc=
k'
>       193 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
>           |                                            ^~~~
>     block/bfq-iosched.c:2660:34: error: 'struct request_queue' has no mem=
ber named 'blkcg_mutex'
>      2660 |         mutex_unlock(&bfqd->queue->blkcg_mutex);
>           |                                  ^~
>
>
> vim +2648 block/bfq-iosched.c
>
>    2642=09
>    2643	static void bfq_end_wr(struct bfq_data *bfqd)
>    2644	{
>    2645		struct bfq_queue *bfqq;
>    2646		int i;
>    2647=09
>> 2648		mutex_lock(&bfqd->queue->blkcg_mutex);
>    2649		spin_lock_irq(&bfqd->lock);
>    2650=09
>    2651		for (i =3D 0; i < bfqd->num_actuators; i++) {
>    2652			list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
>    2653				bfq_bfqq_end_wr(bfqq);
>    2654		}
>    2655		list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
>    2656			bfq_bfqq_end_wr(bfqq);
>    2657		bfq_end_wr_async(bfqd);
>    2658=09
>    2659		spin_unlock_irq(&bfqd->lock);
>    2660		mutex_unlock(&bfqd->queue->blkcg_mutex);
>    2661	}
>    2662=09
>
--=20
Thansk,
Kuai

