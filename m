Return-Path: <cgroups+bounces-14389-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JbEOV1wn2kDcAQAu9opvQ
	(envelope-from <cgroups+bounces-14389-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:57:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424DA19E104
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB81307672A
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC035315D23;
	Wed, 25 Feb 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G/Vq1kfz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFC304BB8;
	Wed, 25 Feb 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056628; cv=none; b=mQIiqDZolHjblYi2O5gsVFaHNUd4GxNUGnAVEgS3n4l07um8VvxYGdZIO1wot/Lnr6W/pr2qaxpEdaGhVh/i03TQw2jhIAPMoXo4iliLpKcy/BmdTTn+Aie1tIyTg5VXfotm5g6KpeP47A+q/KvNquanqW+Rv1CJmszCybbjbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056628; c=relaxed/simple;
	bh=CiFwMFnRC66EdvVEka+nTnJQSeLox1cNdW7WVtL5m2w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=En3Of+W2iEQgQz48/kEmrZc7mF+t1g9ZEzbFuoIryQMK0AnMf977M6LV2iLWIOv3SnPDa4CXPCbUg18IpsyVo23JpA4ejVx+VQkggYYMNJh03ah1ZHBJCgSEoqcAkDB3JVCAor90XpnDdkeD2m2KCiC/5qgow8/k20vE5bdSSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G/Vq1kfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2780DC116D0;
	Wed, 25 Feb 2026 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772056628;
	bh=CiFwMFnRC66EdvVEka+nTnJQSeLox1cNdW7WVtL5m2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/Vq1kfzJAALm4ICHrgT0kZkyQY57Mgf9BP/lWZgfG/fCEURrkmzKL+YInLwxzY/R
	 WXrmUDnN2kHOEsREOKro5+So877c0l1gmR7lBm8biLCHtXYl28JRcFoO9w4wq2rFC4
	 egjuwp8w+JwTvAJUnBP2yzl6gYH06fgJkR4U89yY=
Date: Wed, 25 Feb 2026 13:57:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 00/32] Eliminate Dying Memory Cgroup
Message-Id: <20260225135706.28a93fd5817e0939387275b6@linux-foundation.org>
In-Reply-To: <cover.1772005110.git.zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14389-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 424DA19E104
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 15:48:33 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> This patchset is intended to transfer the LRU pages to the object cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup. A consensus has already been
> reached regarding this approach recently [1].

Thanks, I've added this to mm.git's mm-new branch.

All being well I'll move it into the mm-unstable branch a few days hence.

Then into mm-stable around -rc5.

Then into mainline for 7.1-rc1.

