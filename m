Return-Path: <cgroups+bounces-16129-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Od8LxDIDWod3QUAu9opvQ
	(envelope-from <cgroups+bounces-16129-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 16:41:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720458FD5B
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14DED31B3EA7
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A53ED105;
	Wed, 20 May 2026 14:20:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4D3EA957;
	Wed, 20 May 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286855; cv=none; b=ARJEeuwDEK5FqQ3VCGL91e466l+W3b6PuNEMIHAJAXCCde6Xh6zNzATI4/yNxXybocv53LjaSeHl0gtNWcsT0H0f8Avvsp2dqzaNuR0VqIuV1SzAyflv6LcLimFMRuRFl6E+CTHWLer98lInZkCQA1hIvpt0ua64Gi+WQuxeRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286855; c=relaxed/simple;
	bh=5i5qByXhsNT9btVrUhSfdfclXlW0tZknl2cyzbJWWk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPoeLHOU4q+h/Zn+nOX4FdEs0dw0SalWkOD0vKnv9+pgJThDB3N7WfoLV1iojKuFS3RLRGx6n+vU1/CJG7iwqrciRXEVS2Rp4E9NPpQELrv1scf0t7B+J9G+2lgzk8ikyvdGSv+gKGvagn2yLrhEcLd61SqDZ+Ctm+2TOpKY4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1510d0d4545711f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:86c5b4fb-780d-4085-9a95-b1a3c7dcf50a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:86c5b4fb-780d-4085-9a95-b1a3c7dcf50a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:9ed564c452671c4aa42bea43c981b24c,BulkI
	D:260520203343UF2G41NA,BulkQuantity:2,Recheck:0,SF:17|19|66|78|81|82|83|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1510d0d4545711f1aa26b74ffac11d73-20260520
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1254283229; Wed, 20 May 2026 22:20:41 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: shinichiro.kawasaki@wdc.com
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	cuitao@kylinos.cn,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH] blk-throttle: schedule parent dispatch in tg_flush_bios()
Date: Wed, 20 May 2026 22:20:22 +0800
Message-ID: <20260520142022.1799724-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ag2owaQQoigp_fSV@shinmob>
References: <ag2owaQQoigp_fSV@shinmob>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16129-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2720458FD5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello

Thank you for catching this. 
I tested throtl/004 locally on the upstream 
v7.1-rc4-next-20260519 kernel with the following results:

Without the patch:
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  1.054s
throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
    runtime  1.212s

With the patch applied:
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  0.824s
throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
    runtime  0.962s

I was unable to reproduce the failure. 
Could you share your environment details (kernel .config, scsi_debug module parameters, blktests version)?

Thanks,
Tao

