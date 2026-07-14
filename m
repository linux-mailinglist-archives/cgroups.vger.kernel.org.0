Return-Path: <cgroups+bounces-17756-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9P8OJjzJVWqLtAAAu9opvQ
	(envelope-from <cgroups+bounces-17756-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 07:29:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F6751232
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 07:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=suksangroup.co.th header.s=default header.b="v/kx4sph";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17756-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17756-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=inbox.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3A7231249A2
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 05:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939A306B08;
	Tue, 14 Jul 2026 05:16:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE198309F1D
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 05:16:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006195; cv=none; b=XpGT4G4wIIKKB6kmlFBcnh5mAHJbRwXdnzdG2xQXB+9S1kZ3ZKYlzr+Sjx6+KXv59vxXNrdZgC6P2qetvFjFvGN5cZvGH1ajCJwk3SoGylMq1fNkHJtVJf6PDb9Nt9qhx73NHOBlZJ5+he7jq4od55K2XxWpeLhMnjqzPyobFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006195; c=relaxed/simple;
	bh=bV0Crq7WEkjHVUrf6724K3hQI00bw/RYadNeVkAvTPM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isiYa5NzKIu2EIOn2+/ctsYgHbrwcJffzY5Cjq4sncPK5eFBZQjyehMwfhprgWW97F7RL3RcfRPqpfRwJW/irExjp7X3B9R5bv8PoU6hiKMaT0wSsYi2U3ry+0hMTcxruo5eQ4P3smlcBFClIsHUE3TTPj4pkb+8lUVTIxzJcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=v/kx4sph; arc=none smtp.client-ip=103.13.31.55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bV0Crq7WEkjHVUrf6724K3hQI00bw/RYadNeVkAvTPM=; b=v/kx4sph4oRVgyPHemkBHNNSKJ
	11hObeyZCvTUZM8H9ltb40oX++KNqjBXjhN+cq0ROaTGnfkXVHFgnEwoUCjDGpeKKBoYJZY5qrtfc
	N4S5jZKUJjIDXMWEbTCGohRofbbhA1xHBCSNWXU76nMmOeoRiFlYcsxECPfR/CK5vvSPMhIGF1/AF
	Uotghx5nRynwAyH43tlzZSeee1IHwrldbH/ihauejsHHL+ugdb29uhz+PgQPVVf/R+3lr1t4Irv3d
	0HBZIFbQ/arbX7Y0HCP3yoU6zfHOYja2PsQKncD3FJO7IsGSl0hQGrrI7YGccoT5L2r3cfk+9ud5H
	XwE3O1JA==;
Received: from [207.189.26.187] (port=60967)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVVQ-0000000FrfE-2n7r
	for cgroups@vger.kernel.org;
	Tue, 14 Jul 2026 12:16:31 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: cgroups@vger.kernel.org
Subject: Dear cgroups, project info
Date: 14 Jul 2026 00:16:28 -0500
Message-ID: <20260714001628.E7EA577CE1494844@inbox.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.94 / 15.00];
	ABUSE_SURBL(5.00)[lexcapitalgrowth.com:replyto];
	R_DKIM_REJECT(1.00)[suksangroup.co.th:s=default];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[inbox.org : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17756-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[smtp@suksangroup.co.th];
	GREYLIST(0.00)[pass,body];
	HAS_X_SOURCE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_GMSV(0.00)[smtp@suksangroup.co.th];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[info@inbox.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@inbox.org,cgroups@vger.kernel.org];
	HAS_REPLYTO(0.00)[hanns.schofield@lexcapitalgrowth.com];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[suksangroup.co.th:-];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inbox.org:from_mime,inbox.org:mid,lexcapitalgrowth.com:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 229F6751232


Re:Good day cgroups,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA



