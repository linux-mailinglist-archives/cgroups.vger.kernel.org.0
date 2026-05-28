Return-Path: <cgroups+bounces-16383-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNBiL632F2q5WAgAu9opvQ
	(envelope-from <cgroups+bounces-16383-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 10:02:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC745EE319
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 10:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06E5431FEF0A
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F13546E3;
	Thu, 28 May 2026 07:56:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81214326930;
	Thu, 28 May 2026 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954966; cv=none; b=UzUbbBoYYsKm2DsRMzt/EskevLEcuScqKBS7Hp1N22V3v8Iwq6TUc9Rip1VIcHovEsiudx94D8/CzLSSZkIz84XvMq61zxn/9xdS/h+J6RYrWXMHH7SyC5SWC4xWf4QxmwwbCqMWxORsy0dKRT4lpgOrbe4PlrWg8p4zgl1E0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954966; c=relaxed/simple;
	bh=XqQxthfkv6qf1oZmzZTOfUtUEu7Ncp/WgeS1AD4+RLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG2Yb/x2xbOYCKujBzUBmCeraQY9Q63yTvrJtlKtcIi5dk/UIMitxT2x2vqNTV5NOsqmDxs0On39XDXgHl1hlXVyG+hIun2XjA7FYEpU5tsrg3rjehVx/qFYV9uj4E7CWAx95XOrcckp3u/4nTKot0z2O5x7V8igMBbuYVXZt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6f5245a5a6a11f1aa26b74ffac11d73-20260528
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c8201710-5741-4812-a693-c8ac5cfaeb98,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:c8201710-5741-4812-a693-c8ac5cfaeb98,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:813f779d6722cf99add929ab5d23f428,BulkI
	D:260525214329UXPT78B0,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:-10|0|15|50,EDM:-3,IP:-2,URL:0,File
	:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a6f5245a5a6a11f1aa26b74ffac11d73-20260528
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 278844867; Thu, 28 May 2026 15:55:53 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: jgg@ziepe.ca
Cc: cgroups@vger.kernel.org,
	cuitao@kylinos.cn,
	hannes@cmpxchg.org,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	mkoutny@suse.com,
	tj@kernel.org
Subject: Re: [RFC PATCH rdma-next 0/5] cgroup/rdma: add per-type resource accounting for QP, MR and MR memory
Date: Thu, 28 May 2026 15:55:37 +0800
Message-ID: <20260528075537.2170697-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527133400.GM2487554@ziepe.ca>
References: <20260527133400.GM2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16383-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2BC745EE319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,Jason

> memory pin accounting should ideally be limited by the cgroup directly
> but we argued about that for a while and could never get an agreement
> of an acceptable implementation. There are many nasty corner cases
> around cgroups and fork and other cases IIRC
>
> So I'm not sure if making it rdma specific can easially solve these
> problems

Thanks for the detailed context.  I understand the concern — generic
pinned-page accounting at the memcg level has difficult ownership
semantics around fork(), cgroup migration, shared mappings, and page
lifetime tracking.

The intent of mr_mem is narrower and RDMA-scoped.  It is not page-level
ownership tracking — it is object-based accounting tied to the MR
lifetime:

  - charged at MR registration time
  - uncharged at MR destruction time
  - the charge lives with the MR's creating cgroup for the entire
    lifetime of the MR object

This model intentionally defines accounting semantics around MR
object lifetime rather than page ownership:

1. fork(): The accounting model is based on MR object ownership
   rather than ownership of the underlying pages after fork().
   fork() does not duplicate MR objects.  Even though the child
   inherits the uverbs fd and can access the parent's ucontext,
   the MR remains a single kernel object — fork itself creates no
   additional MR registrations or associated RDMA resource accounting.
   The charge is tied to the MR object, not to the number of processes
   that can reach it, so no splitting or re-accounting is needed.

2. Cgroup migration: mr_mem follows the same semantics as the existing
   hca_object — charge at creation time against the invoking task's
   cgroup, uncharge at destruction time.  The RDMA cgroup does not
   implement can_attach/attach callbacks today, so charges do not
   migrate with the task.  This is a known limitation that applies
   equally to hca_handle and hca_object.  mr_mem does not introduce
   any new complication here.

3. Overlap with memory cgroup: mr_mem does not count process memory
   usage — it represents a per-device DMA registration budget: how
   much memory can this cgroup register through a given HCA.  This is
   a different dimension from what memory cgroup tracks.  An
   administrator might set mr_mem limits differently per device, which
   memory cgroup cannot express.

   In particular, mr_mem tracks the registered memory range associated
   with the MR rather than exact dynamically pinned pages (e.g. for
   ODP MRs).  This is a stable, policy-oriented approximation of
   registration footprint — not an attempt at precise physical page
   accounting.

If you think this RDMA-scoped approach still has unresolved problems,
I'd appreciate guidance on which corner cases remain problematic.

Thanks,
Tao

