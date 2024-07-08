Return-Path: <cgroups+bounces-3562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5345D929BBF
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 07:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735B71C20E19
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 05:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FAABA53;
	Mon,  8 Jul 2024 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DPEKA8RC"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124CBA45;
	Mon,  8 Jul 2024 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720417473; cv=none; b=MBMD04ICkzFXBdrAxlLelkH1PkRKQNTPtXRuVCiVtiMObpRHjyBLmivg2QvfPaVmJzhiulsZiEZHhWPyi8V3bcTosDib+21u6iM83/1bTctcOKmCVxjKWMW4aJ5t3KXwhThBqTIhVi0KbccyfTK0Bw7Sj+iC6XFLsEJnHxOWLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720417473; c=relaxed/simple;
	bh=DALaIj5D0ngUpE3QcDtL9Tx75VDgfDtCcQoihqem+eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN3SMbSksgLAdQSKIfNU73tG47sOTGppPfog9caKGyzvBzKBeg4yjTC04jsXwqJJt5mRQILGLgV+KIoo8d67sA2eQpJ4UDl2Xcr3C0fINJVUB3dgjcFT9CzSjlSmeJn80AUUZHYmMz9XfR6WGQ2HOuCjYkZsCIQ3/T4eCeb8wbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DPEKA8RC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720417435; x=1721022235; i=markus.elfring@web.de;
	bh=DALaIj5D0ngUpE3QcDtL9Tx75VDgfDtCcQoihqem+eU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DPEKA8RCl31fbApspxGmofEe1CpWf/Y4h/qY77AaJpmutiCrlSQzE5Q8SCliwWMk
	 jT7D48TDqlJtylnjHZCBstAo+D/MJS/UQ+bZqpefwR8PkpU8K/LxQiLd84XIu9Ssr
	 qi4fX+teEcKS6CLwdDP4HQG5ofVMhkw3Do/SwbdZvPbEUHD2chRC4d1RYqo5SnMQN
	 F5Xh9PoPKTkGpyx1YTXTTc1PpZQMZCu2GLaxSVn4vHaiIIKy4R/9rkwp6P35l/e5y
	 jqfUREE2b/TdfCSvhRa2L0RtP+1aibPSM2Bgi2+Pb+XsaOt5zQpXC9fsWkj+a44Pc
	 cfqvf8KG7B9F6q2Wvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6y1-1rqoRs3EI7-00pRod; Mon, 08
 Jul 2024 07:43:55 +0200
Message-ID: <9d07628a-eadd-4e50-b7a8-02adb25981ab@web.de>
Date: Mon, 8 Jul 2024 07:43:20 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blk-cgroup: add spin_lock for u64_stats_update
To: =?UTF-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Burkov <boris@bur.io>, =?UTF-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?=
 <Iverlin.Wang@mediatek.com>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tejun Heo <tj@kernel.org>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
 <8f3765db-842d-4568-9ac5-1bd9cab9e952@web.de>
 <554f09bc6fc8f3b2a71b346f5e363950a1f8cb18.camel@mediatek.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <554f09bc6fc8f3b2a71b346f5e363950a1f8cb18.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3sJU37sIvlaJq7Km1wDF5IIF4lzBgJzAmJNGao7ZbnmtFMNOGEX
 a0M9mcYkZu6NHcupZ5lRmhoRGXAvsPZtDR5HnRyla7hrTOgSetDPKpk5MMaUq9uq37xcIBU
 JTyw2tNXilctDrEL9RL5hkyqtv4YdR9V8Q2kRV9KYqGzVjcXA0zrjukgdO1SXx5zScIBBvb
 x3REhI7jDbxSPP+oZ7Tpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:THrU1lGh5FU=;odnaXHAtD4xNlL0C54CvnW5dGsU
 vi0bGEuPK7OVwPaqNt5nY/qch3F0LELkYsaF1ZUmv4PFt4fX5XmFiOw9o6a9XpPOguq2QOOG+
 kVbVbnRx90tteILmOYk2VRJ9O4wW0Kt65knqOOSJEt83KoueTrMqc2WNGy6qzH2ZeGR8s1aaW
 FaDFs5cqbgz3upkkJMZRxItKUp4Q3t+UFPEasd82wM+Gkt5E/IfLcEi8oeSXg36PlCDc233n9
 piLw9rhylMR/vWzfNmmEeN6ukRVq+Wg5zAUg2tK7daB89EXhfThnFRdtov5eKrqOP13lGpXJ5
 1t3EoDH4H3N+NKNLt7EhbMXDuP6G8HOdsgRS6N9rIwNx/jryZzTK5SZP4ObWXLUI/vxiMlRAP
 5O8LFZEThu97Jh2Xx0+ooSsOsIGdPOqmYtT0P0/TEIDwmjWX6NqrmzQxCmt6edTa0pwp62Kpm
 vhpPxQlcCn2S2gRbWDZby6oj0Zb4sHy1CaP0HbgWU5CEJWs9VrJbxiTi3apBl27iO3ntiT16L
 y+4WjAidinrjGY6Ub4fBmwfGgI52pjLsU7VIm9ZQqiOIWlLiwlD9iAhNLj3lDRuVAHiIjVOiy
 CVCalkeyyr0d1N/Ya7SHfxvsE1gaHbmtte1tHo5i/ZlbRZfmwRjF+ZTeXR5LYh9KOoNwkW7Sv
 +h5NxqoqTKOrBGCkKDW2d30m9V2gGUCPlt3iOIc1LOuJwqiEKP1xZ4OKvWXnB7GYWS/Gx4tkc
 +3Lx1l7Q+1/1SElJv36H2dK8PUifBGWySckTJPv7meWdq72Yk+3FbPZKDwQXE3rUekzhDEpe2
 ErGe3j+PwwEj+ggUGfPbebp2fiueh/HwaoZ90i/cdG24g=

> ************* MEDIATEK Confidentiality Notice ********************
=E2=80=A6

Please omit such information from your patches for Linux software componen=
ts.
Such hints do probably not fit to communication characteristics of Linux m=
ailing lists.

Regards,
Markus

