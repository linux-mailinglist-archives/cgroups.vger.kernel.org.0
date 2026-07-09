Return-Path: <cgroups+bounces-17618-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LU5NA2t6T2oZhwIAu9opvQ
	(envelope-from <cgroups+bounces-17618-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:39:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6D72FB7D
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:39:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b="G2/vTerT";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17618-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17618-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EDF63227CAC
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB02440911C;
	Thu,  9 Jul 2026 10:03:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lf-2-50.ptr.blmpb.com (lf-2-50.ptr.blmpb.com [101.36.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E03408007
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 10:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591414; cv=none; b=rP/kbr1EY8xUjOJul1tn3X79X/i++FdZxtHEBJRkKOfpETWjSS4KP9nY8lf/0XqbOWwMWY7vnmSb+4P0Hk1bznKR5Wd8gVJ+JTv72bcctf8cMdTrP3X7I8dPbF0yySeTCP7TSyYypkAAhHXGA7MCgs0zWbHwLmccRUpXgI1gL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591414; c=relaxed/simple;
	bh=js3GOE6eNJYLE/SjBEOjGlHKW//nqpck89PQglEeI7I=;
	h=In-Reply-To:To:From:Content-Type:Subject:Date:References:Cc:
	 Message-Id:Mime-Version; b=NhMYbA4gCIciwCMbJEB2FLAbY6Vzey/Vs7I1xOC12rqQrNdsEhvqCxX/CjdtMQOFBEni7aR90QKNwUwz03/uW4BR6TLY9JnVEXdPv/RBCBRlGeaRMKgr+r1Z4wqr2P0O7Sa4wYhiEt+5NiXwx3uLb4L2T6zd9hYTGl+ZJalkMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=G2/vTerT; arc=none smtp.client-ip=101.36.218.50
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783591358;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=js3GOE6eNJYLE/SjBEOjGlHKW//nqpck89PQglEeI7I=;
 b=G2/vTerTQHVKtUCxf0lbYJ0hD0o24yQuAOYZfOu3oqx72JtArWF+1mfZkEdVbxfzLDRz6q
 iiQOtwXK8oV5Vh/9rVAXL5YLZF8VWnRdHeaOabmwZea1CR0bqYShjrbgzlzaFe0NZFRjxI
 hYv7UTUuPNvUIxq+JdRwNMzlc6TWu+PrYMkaPTB+jnDBPHPqXG4k7YDqB9NkpeEMrRNksq
 f2qCNYH3u6vRGIexQcZr6CL9Tns4iH7Xj9i3DvNuq28JzCZr2DDSlhsKLB+9d0HNfutR3s
 A+wWC8WII7c2fSC96nXNxARmuT20KfUrCYssTMoQTjyRxqCZRmCo1zWRS6kabg==
In-Reply-To: <20260709061500.GE16504@lst.de>
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a4f71be+0de08c+vger.kernel.org+yukuai@fygo.io>
Subject: Re: [RFC PATCH v1 07/17] block: support non-blocking bio allocation with a bdev
Date: Thu, 9 Jul 2026 18:02:32 +0800
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-8-yukuai@kernel.org> <20260709061500.GE16504@lst.de>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 10:02:37 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fygo.io
Cc: "Jens Axboe" <axboe@kernel.dk>, "Tejun Heo" <tj@kernel.org>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"Alasdair Kergon" <agk@redhat.com>, 
	"Benjamin Marzinski" <bmarzins@redhat.com>, 
	"Mike Snitzer" <snitzer@kernel.org>, 
	"Mikulas Patocka" <mpatocka@redhat.com>, 
	"Dongsheng Yang" <dongsheng.yang@linux.dev>, 
	"Zheng Gu" <cengku@gmail.com>, "Coly Li" <colyli@fygo.io>, 
	"Kent Overstreet" <kent.overstreet@linux.dev>, 
	"Josef Bacik" <josef@toxicpanda.com>, 
	"Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>, 
	<cgroups@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>
Message-Id: <ee70f959-b61e-45d2-b1f0-22bee85b0bdc@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17618-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:yukuai@fygo.io,m:axboe@kernel.dk,m:tj@kernel.org,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo-io.20200929.dkim.larksuite.com:dkim,fygo.io:from_mime,fygo.io:replyto,fygo.io:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42E6D72FB7D

Hi,

=E5=9C=A8 2026/7/9 14:15, Christoph Hellwig =E5=86=99=E9=81=93:
> Maybe we should just move the blkcg allocation back to bio_submit where
> we know we can sleep?

This sounds good, I already switch blkg allocation just before submit_bio()
in some cases in this set.

Just one question, for nowait case, is it correct that we still can't sleep
during submit_bio()? If so, I still need to add nowait special case during
blkg creation. Or I can just return -AGAIN if blkg lookup failed, this is
much simplier.

>
--=20
Thanks,
Kuai

