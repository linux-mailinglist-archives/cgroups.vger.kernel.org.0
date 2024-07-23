Return-Path: <cgroups+bounces-3860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF00939EFA
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 12:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2801F1C21DF7
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDAA14EC5D;
	Tue, 23 Jul 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="edt6oRj+"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766C3D6A;
	Tue, 23 Jul 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731853; cv=none; b=eYS14D8xx35xWC+5DOPoXCNyTRjZJqBdvCCDpvt20VEYzJWcj9UF9RpqJP8gEiQyiIBGYZFea+EBtjig1Q4IhYh0ynYn4QG8+QRkKjRhc2LwHSePBss6jSccKxrx3erQgO8bYgmECZI/JfDZaM0Dy+3pyl/HybN0sNnjEFpY5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731853; c=relaxed/simple;
	bh=bFV1ApnZr6l41hbLy78ecKlgGLcfy1MgJ0JGOpKuthU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNvhulCbwWvHcKevoxkgo6z2VNm27VS/whH2dOM2sNcSefpJfh4i4WMOhSDT2RTbNhp4D6FB84NpaX37l3/qEXeo3BCfBFTKBAsP/PVx3t/Ob7g/rK+le7F4NsNTdHHjZr5liAjv6I+Q5IcBO3OA4WpV9PUFUKVBX48Jb9nPY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=edt6oRj+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721731823; x=1722336623; i=markus.elfring@web.de;
	bh=bFV1ApnZr6l41hbLy78ecKlgGLcfy1MgJ0JGOpKuthU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=edt6oRj+1Z/TF3SRe8VhID6W/uslTRY96qmg51fHfnDW25ZTK07M/O2CDf4ctyci
	 jxdqhsI8yrX1KciwXoCZTBnk6GTWcwhjBubutSUuGMyWojcHz7eJr2EEXN5gP/ik/
	 bv4jjtxF6W1GvCN1iAWL2x1s47xehV3AXrq3EM5Z1cJNuyKzQcSaPMgNq7rbJiqPC
	 EUxwTXNs2NBIGDwEAjHb5gRStUMH84SuSoOkj1s0FCie/jPRGyIlYq0axFOpmN7t7
	 1C3H1dxHzThmyeL2xXGbwClJD19TsQFDC9Rp0WiLp7eIfkQOZsX5XzAYi8Y1YX9UQ
	 ZhUakhYFGhU/LTWjWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1sdwr52AbM-00BgE6; Tue, 23
 Jul 2024 12:50:23 +0200
Message-ID: <57cc9da4-93ad-4279-a175-2e291ccc8a47@web.de>
Date: Tue, 23 Jul 2024 12:50:22 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup: Use seq_putc() in three functions
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, kernel-janitors@vger.kernel.org, cocci@inria.fr
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, LKML <linux-kernel@vger.kernel.org>
References: <8ff2d1aa-4c48-4cb1-b5d5-675adb90ae81@web.de>
 <mbv6jl67qw43ruzf55yzgdo7zrusvuod2c3b7cfgliypyh7pgf@mqneyza5cffr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <mbv6jl67qw43ruzf55yzgdo7zrusvuod2c3b7cfgliypyh7pgf@mqneyza5cffr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XPtjKtOmu+o1KiPudxOTGi3zEakWysdnmkb4xMg3GL/Xjgum9h7
 rvU7oC2MlNYESZIUF5C8rdKOgBA7eQmpxRoG56BsXWmor0fzdhqxObsRahUxGlc/hRCG3AH
 dFFrmh+6yJo2G12Zmn5oCrFsOAfghrTclwc1WArIp3R3hSoeuYRM0cmnqAeZt+NUnQYpNSL
 z8V+plr+Bmf/rrUWpVlxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u53tujkg5OE=;QR1UYRuThn7/hO8mc7T4sdzZ4vJ
 lAFwAKSsLPp6NmXwrC5pyQrgLE+i2iSVtFfuc3AY6fS7otaojj6325sTP6DFR5EZ4rdo/R6sv
 UKBpUKUc9YttrbEv2bu1t3+ZRURZ956g+zgCqMkTyeS0pFoM+P1JwuOm1C+LSobZbR2hG1+Kp
 xTbpwgsRKA5Kxdiw/5UFGAoevXKDuMq9V3rGBQlDb7x0zDf3jXLnVDLX7S/3E3Uw/LtHtogW/
 hw/xzzH0C/s9BDSDIZFEtIVIdc5gfeEkYEFb+nZ7NP7Q5byN9YOzT888qt65fLlTeixKo7oQ7
 Uwlj4mDL4pDsR7ZUtwrNxgBOM/+NBaE3nPgyEiN6ft4Nx9wZDyiDPUwOMnPM1JNET0/kd7Dmb
 7PA2fXfBDFrz+ExaUjIn33ySCQJ5gnQ78Qa4ELyHKS8cliNxEHWRq9nRrsN1lnZjRbA65AFxY
 Gko8k6PC/Ucayk9di8OvpZmYYITwERahqZFpp3buEuqWs9bkgEa8YClgesQA3VTJ+FtE6Cr/z
 RMXYPv0qdpcEiupZcKXsrbmLXOtyWNdBRoahRTotfaU1922NU3fJXU+cj6G9E6w/uGQ9OgZuH
 sz3p6gjVw2aCsfuYyeef4HCEVekPDGIl0yPQzWdptRVHwt15GvgGSVZnZ65rM2kjiDrY91/jb
 Gh/sRoqeyDiPr2U0nPGp66Cswp9UMTdjp9vbX9aDbwfgh5sCtzcG0Ztb03CjCMSGoJPfyzdMA
 Jm43tjRUw3Su41g7EQ0OCOErniOWwa86vDgi8Nb1RfQdcRVWVfTJuLUFOzlzdoMAaDYiGaSOR
 jPiDqs3WKB4XOSGV8dGRygng==

>> This issue was transformed by using the Coccinelle software.
>
> Maybe that would better fit under scripts/coccinelle/misc for optional c=
hecking.

Would you like to support any corresponding developments also according to
the coccicheck tool?

Regards,
Markus

