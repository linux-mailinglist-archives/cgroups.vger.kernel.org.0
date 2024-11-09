Return-Path: <cgroups+bounces-5500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB009C2F5B
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 20:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5601B21451
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73919F115;
	Sat,  9 Nov 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="PSRM/Tuz"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA361537C9
	for <cgroups@vger.kernel.org>; Sat,  9 Nov 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181139; cv=none; b=Kpw9MSIo3NmY7Cky4XrCWBOMzUgNUrC6f16oX2vYN6ctaloDFSyGQQJzdwTeRJvIYLH0RJlmyBi48kpsdAQ7GFnFRTETCXAF7glQ5Ytn/rUsN9rrTt14ag2EKIFwAYgib7rrFiip2D+3t3oZHYLpoM71cFCXuJCIvfDx9UvZivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181139; c=relaxed/simple;
	bh=FeA9WAXqp4bAFji2TrJz36pKDcbCxkOI3Ko0PDWkIJU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GwjNGoCYFGD3fx6fQ08+qJ9o3u5xlCPB+f4Hlizkupa8kuVwKfk3ZN5w/MbBxdtwB1MvS5BSKCGzh4lfXM728Rh7NfJZv+tIwMRTMZ1vAgq0EgREDVB68tsYBNjwIAWMPmkTuHxhJAH84ewwqc3BLLAXv8t0VUrdR9NuziWOESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=PSRM/Tuz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731181134; x=1731785934; i=toralf.foerster@gmx.de;
	bh=FeA9WAXqp4bAFji2TrJz36pKDcbCxkOI3Ko0PDWkIJU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PSRM/TuzX+xlrKF7voBKlI9/2d2l9CWehrk5zCFp+uEkhYVSb6s4NhuJjVleMruy
	 bo6aO+c4r7bkCKF3a2OB8mI6cQgrGFTDHn5hmtp+2wNepicrrqp7nq6ocpgbJOkBx
	 Doo6XeLwQ4vBOKvRg/e5CrxdhwF2GjeMch5F7AMMQTuFIWgklJs47REPFIGRvyqeN
	 vnxAU7PCvoCSlixcEzrvbL1MOlpPpxeaNl81i8mqh+sq2eec9/hInNMl/RbGHBl9A
	 6R1XY0Wzhyp1cmGnWhtjkUu4KpN4B13MdtpsecOYembNMFQkgtFKrdKZC4isTrF3S
	 oRNe9kq0iaHLU5gomw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.8.6.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1tbQxR1Xwp-00cCMA for
 <cgroups@vger.kernel.org>; Sat, 09 Nov 2024 20:38:54 +0100
Message-ID: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>
Date: Sat, 9 Nov 2024 20:38:54 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cgroups@vger.kernel.org
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: process running under Cgroup2 control is OOM'ed if its stdout goes to
 a file at at tmpfs filesystem
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 xsPuBFKhflgRDADrUSTZ9WJm+pL686syYr9SrBnaqul7zWKSq8XypEq0RNds0nEtAyON96pD
 xuMj26LNztqsEA0sB69PQq4yHno0TxA5+Fe3ulrDxAGBftSPgo/rpVKB//d6B8J8heyBlbiV
 y1TpPrOh3BEWzfqw6MyRwzxnRq6LlrRpiCRa/qAuxJXZ9HTEOVcLbeA6EdvLEBscz5Ksj/eH
 9Q3U97jr26sjFROwJ8YVUg+JKzmjQfvGmVOChmZqDb8WZJIE7yV6lJaPmuO4zXJxPyB3Ip6J
 iXor1vyBZYeTcf1eiMYAkaW0xRMYslZzV5RpUnwDIIXs4vLKt9W9/vzFS0Aevp8ysLEXnjjm
 e88iTtN5/wgVoRugh7hG8maZCdy3ArZ8SfjxSDNVsSdeisYQ3Tb4jRMlOr6KGwTUgQT2exyC
 2noq9DcBX0itNlX2MaLL/pPdrgUVz+Oui3Q4mCNC8EprhPz+Pj2Jw0TwAauZqlb1IdxfG5fD
 tFmV8VvG3BAE2zeGTS8sJycBAI+waDPhP5OptN8EyPGoLc6IwzHb9FsDa5qpwLpRiRcjDADb
 oBfXDt8vmH6Dg0oUYpqYyiXx7PmS/1z2WNLV+/+onAWV28tmFXd1YzYXlt1+koX57k7kMQbR
 rggc0C5erweKl/frKgCbBcLw+XjMuYk3KbMqb/wgwy74+V4Fd59k0ig7TrAfKnUFu1w40LHh
 RoSFKeNso114zi/oia8W3Rtr3H2u177A8PC/A5N34PHjGzQz11dUiJfFvQAi0tXO+WZkNj3V
 DSSSVYZdffGMGC+pu4YOypz6a+GjfFff3ruV5XGzF3ws2CiPPXWN7CDQK54ZEh2dDsAeskRu
 kE/olD2g5vVLtS8fpsM2rYkuDjiLHA6nBYtNECWwDB0ChH+Q6cIJNfp9puDxhWpUEpcLxKc+
 pD4meP1EPd6qNvIdbMLTlPZ190uhXYwWtO8JTCw5pLkpvRjYODCyCgk0ZQyTgrTUKOi/qaBn
 ChV2x7Wk5Uv5Kf9DRf1v5YzonO8GHbFfVInJmA7vxCN3a4D9pXPCSFjNEb6fjVhqqNxN8XZE
 GfpKPBMMAIKNhcutwFR7VMqtB0YnhwWBij0Nrmv22+yXzPGsGoQ0QzJ/FfXBZmgorA3V0liL
 9MGbGMwOovMAc56Zh9WfqRM8gvsItEZK8e0voSiG3P/9OitaSe8bCZ3ZjDSWm5zEC2ZOc1Pw
 VO1pOVgrTGY0bZ+xaI9Dx1WdiSCm1eL4BPcJbaXSNjRza2KFokKj+zpSmG5E36Kdn13VJxhV
 lWySzJ0x6s4eGVu8hDT4pkNpQUJXjzjSSGBy5SIwX+fNkDiXEuLLj2wlV23oUfCrMdTIyXu9
 Adn9ECc+vciNsCuSrYH4ut7gX0Rfh89OJj7bKLmSeJq2UdlU3IYmaBHqTmeXg84tYB2gLXaI
 MrEpMzvGxuxPpATNLhgBKf70QeJr8Wo8E0lMufX7ShKbBZyeMdFY5L3HBt0I7e4ev+FoLMzc
 FA9RuY9q5miLe9GJb7dyb/R89JNWNSG4tUCYcwxSkijaprBOsoMKK4Yfsz9RuNfYCn1HNykW
 1aC2Luct4lcLPtg44M01VG9yYWxmIEbDtnJzdGVyIChteSAybmQga2V5KSA8dG9yYWxmLmZv
 ZXJzdGVyQGdteC5kZT7CgQQTEQgAKQUCZlr7JAIbIwUJGz7piAcLCQgHAwIBBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEMTqzd4AdulOMi0BAIVFLcqeuKNkEPEHdsVtuo5kOJsRaquQK4Bq4ejw
 RNzuAP9sNBBLhdtCibq8VVx/SxZ5tMSA1+cRCF/v8HUL/X57dM7DTQRSoX5YEBAA2tKn0qf0
 kVKRPxCs8AledIwNuVcTplm9MQ+KOZBomOQz8PKru8WXXstQ6RA43zg2Q2WU//ly1sG9WwJN
 Mzbo5d+8+KqgBD0zKKM+sfTLi1zIH3QmeplEHzyv2gN6fe8CuIhCsVhTNTFgaBTXm/aEUvTI
 zn7DIhatKmtGYjSmIwRKP8KuUDF/vQ1UQUvKVJX3/Z0bBXFY8VF/2qYXZRdj+Hm8mhRtmopQ
 oTHTWd+vaT7WqTnvHqKzTPIm++GxjoWjchhtFTfYZDkkF1ETc18YXXT1aipZCI3BvZRCP4HT
 hiAC5Y0aITZKfHtrjKt13sg7KTw4rpCcNgo67IQmyPBOsu2+ddEUqWDrem/zcFYQ360dzBfY
 tJx2oSspVZ4g8pFrvCccdShx3DyVshZWkwHAsxMUES+Bs2LLgFTcGUlD4Z5O9AyjRR8FTndU
 7Xo9M+sz3jsiccDYYlieSDD0Yx8dJZzAadFRTjBFHBDA7af1IWnGA6JY07ohnH8XzmRNbVFB
 /8E6AmFA6VpYG/SY02LAD9YGFdFRlEnN7xIDsLFbbiyvMY4LbjB91yBdPtaNQokYqA+uVFwO
 inHaLQVOfDo1JDwkXtqaSSUuWJyLkwTzqABNpBszw9jcpdXwwxXJMY6xLT0jiP8TxNU8EbjM
 TeC+CYMHaJoMmArKJ8VmTerMZFsAAwUQAJ3vhEE+6s+wreHpqh/NQPWL6Ua5losTCVxY1snB
 3WXF6y9Qo6lWducVhDGNHjRRRJZihVHdqsXt8ZHz8zPjnusB+Fp6xxO7JUy3SvBWHbbBuheS
 fxxEPaRnWXEygI2JchSOKSJ8Dfeeu4H1bySt15uo4ryAJnZ+jPntwhncClxUJUYVMCOdk1PG
 j0FvWeCZFcQ+bapiZYNtju6BEs9OI73g9tiiioV1VTyuupnE+C/KTCpeI5wAN9s6PJ9LfYcl
 jOiTn+037ybQZROv8hVJ53jZafyvYJ/qTUnfDhkClv3SqskDtJGJ84BPKK5h3/U3y06lWFoi
 wrE22plnEUQDIjKWBHutns0qTF+HtdGpGo79xAlIqMXPafJhLS4zukeCvFDPW2PV3A3RKU7C
 /CbgGj/KsF6iPQXYkfF/0oexgP9W9BDSMdAFhbc92YbwNIctBp2Trh2ZEkioeU0ZMJqmqD3Z
 De/N0S87CA34PYmVuTRt/HFSx9KA4bAWJjTuq2jwJNcQVXTrbUhy2Et9rhzBylFrA3nuZHWf
 4Li6vBHn0bLP/8hos1GANVRMHudJ1x3hN68TXU8gxpjBkZkAUJwt0XThgIA3O8CiwEGs6aam
 oxxAJrASyu6cKI8VznuhPOQ9XdeAAXBg5F0hH/pQ532qH7zL9Z4lZ+DKHIp4AREawXNxwmcE
 GBEIAA8FAmZa+yUCGwwFCRs+6YgACgkQxOrN3gB26U7SJQD/XIBuo80EQmhnvId5FYeNaxAh
 x1mv/03VJ2Im88YoGuoA/3kMOXB4WmJ0jfWvHePsuSzXd9vV7QKJbms1mDdi5dfD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oP6eqTS+X2Y9jWcTH3FhsZszdDuAyNtpk8pXK2xrCI/Fmx61fn/
 M4h1fs2czURS6f1DDt/NRbpNfGTXFD65iaIiEm6Rb13t+iF749uxCUAp/VQIgKQyzqE011O
 1muQITTjnf3NO1GLyzbXMaztAlOO1prOynorLTzwcNCC8teehGGIS39o1Ug5L6LwKhUIB3E
 Q69LrVXgmJE5QexfOXD7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kn+mHrXqlAQ=;1V6W6DvfR19NzXjud8ieqhJMd3r
 isGW0CnZywAk68UI4FqxtRJDBV4dKnPU4O9GRqVGhSkG7BddKU4rtAjNWBJT9NJJ6Wt6b7K1b
 LH3OicQUvI31hIEKyPZ2I1+RMCFOmjO1OJDdA6GpfD7SO095zT3g3k2KOhOTDy7OHjrvnxmkd
 Sg1PZq+zdkJxMpa6lqWna6HD8VQSfjgAT0Lo/CT3u2t6GZj1u5gwF0W7KlldQZR1Is15ujQx1
 fDtTnvI2z57lx1WQxy0ornJM1iJ7/vf3/diNRxTXtJ6W8TCRpgl+S1RDTmzUK1DLkrIsWoNQF
 gb5VNjbignLCPo5M9Gy2Op6xYJtlC8PBMrep1GfB23abgLdPytARc1QqFCT6o81ZEmOjXvKmb
 Y8CFYAKutd9u07pOJN8AK74URfyZq3IDDD0Z/qFhgZzwft79XHvERoZruJxkTtpclf1q2tQga
 c81iOPcX6X6lvO36dJrfiRDAQqKjOANfj5idachuwyxw+hNeKQ5O1YB0bI9c16JCih1ZNHR9U
 1m1/7unRC+P2QMLmL2iOhhRF/TyZiSIC9ire08cjL0Wrbfylcvj8JtONOvK69cgkocDBNJLwl
 aFwtbiOoX7FK2rGBYes1W2tKsmgqLEpL9feIkXO7CXFQFbEnTJ+8bGz2susk+ZsO//KOKiOJ4
 o9OOgrDYM6OFe7PCa5ze5vLyrzhvwMzrB14dl+2IYujXDXKUmnKhMDa/bHE8uemtnO80YkhGL
 F55xzU55tHEsf1Ik2oAr/a2sSdu3vzgM+wxsclkvsWJ3alqnYvbUZjsnpf+rI5EqDolo/T0Ek
 L/Mii+BrqnN6wQMwcfX+1X/Q==

The reproducer in [1] shows that a process running under Cgroup2 control
is OOM'ed if its stdout goes to a file at at tmpfs filesystem.
For a regular file system that behaviour is not reproduced here.

I do wonder if this is a feature?

[1] https://gist.github.com/toralf/0dbb422c0889c594165a8be69e610a86

TIA
=2D-
Toralf


