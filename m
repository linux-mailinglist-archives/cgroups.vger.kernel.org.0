Return-Path: <cgroups+bounces-15354-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bk8Ab5442lHHQEAu9opvQ
	(envelope-from <cgroups+bounces-15354-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 14:27:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C37421161
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9D4F300BE91
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D853624B3;
	Sat, 18 Apr 2026 12:27:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E235838B
	for <cgroups@vger.kernel.org>; Sat, 18 Apr 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776515256; cv=none; b=OKu9x5wsMMgkd/nQ4rxlN3VsRox02Hp4EquIsZPcFN4ZVzQxl+hIfphYEWYxjpkuV8XK7k6HnoEnR5f9Yl/y7vu4/RvSHbuEyFtZhR8++CqZeov5+/j1ol0r9kEZuvx62Uzn8fHcaswAAXxgeh1H2jv19w4t1ixCgPDl0X07mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776515256; c=relaxed/simple;
	bh=789KyVGeT3sgUL0ELlTj+p02bnEamtRqykKebIxryAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF8HtYhWLc45K3XDpDsvwsvSElafPuhqkWEL4vBpjPDr1rS5zKYIXbwbN9QKSLokVPx2kRZS/dALX8r54Zdz68VIK+rxp5j37nRm1k1YzSeK4aNsJSD81Kzwd+do8iTh8+0sbA/o6m+ay1w3K9ByoO875m2w0+4Vu88EBAVfwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 18 Apr 2026 21:27:23 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 18 Apr 2026 21:27:23 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 11/11] mm, swap: merge zeromap into swap table
Message-ID: <aeN4qzqfyFpWJXYZ@yjaykim-PowerEdge-T330>
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
 <20260417-swap-table-p4-v2-11-17f5d1015428@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-swap-table-p4-v2-11-17f5d1015428@tencent.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15354-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 08C37421161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 02:34:41AM +0800, Kairui Song via B4 Relay wrote:

>   *
>   * Usages:
>   *
> @@ -74,17 +76,22 @@ struct swap_memcg_table {
>  #define SWP_TB_PFN_MARK_BITS	2
>  #define SWP_TB_PFN_MARK_MASK	(BIT(SWP_TB_PFN_MARK_BITS) - 1)
>  
> -/* SWAP_COUNT part for PFN or shadow, the width can be shrunk or extended */
> -#define SWP_TB_COUNT_BITS      min(4, BITS_PER_LONG - SWP_TB_PFN_BITS)
> +/* SWAP_COUNT and flags for PFN or shadow, width can be shrunk or extended */
> +#define SWP_TB_FLAGS_BITS	min(5, BITS_PER_LONG - SWP_TB_PFN_BITS)
> +#define SWP_TB_COUNT_BITS	(SWP_TB_FLAGS_BITS - 1)

Hi Kairui :)

Would this break the build on 32-bit arches with 40-bit phys
addrs (MAX_POSSIBLE_PHYSMEM_BITS = 40)?

Architectures I checked.
  - ARM LPAE   (CONFIG_ARM_LPAE=y)
  - ARC PAE40  (CONFIG_ARC_HAS_PAE40=y)
  - MIPS XPA   (CONFIG_XPA=y)

Calculations.

  SWP_TB_PFN_BITS   = 28 + 2 = 30
  SWP_TB_FLAGS_BITS = min(5, 32 - 30) = 2
  SWP_TB_COUNT_BITS = 2 - 1 = 1

The BUILD_BUG_ON looks like the real problem. it needs at
least 3 count values (free/used/overflow).

  BUILD_BUG_ON(SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2);

Confirmed with a cross build (multi_v7_defconfig + lpae.config).

  error: BUILD_BUG_ON failed: SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2
    at __count_to_swp_tb (mm/swap_table.h:227)

I think the right fix is widening swap_tb to 64 bits
unconditionally (atomic64_t).

(Or, uglier, these arches could always route counts through the
extend table.)

Best regards,
Youngjun Park

