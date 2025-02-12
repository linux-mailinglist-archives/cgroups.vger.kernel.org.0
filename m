Return-Path: <cgroups+bounces-6523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E252FA32678
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 14:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F387A2595
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9420D516;
	Wed, 12 Feb 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZngAeNPs"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A6204F6A;
	Wed, 12 Feb 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365404; cv=none; b=dTbEsUAdoYFbLnCn0eANNrqShjt6U/6gkUD3I8v+rjxQR8LKokUFA/12DsW4JaBO2n9nS2zIK9RqCgPjIQkaMLGWD74PZfmHhQ1LUZ0KdyZPO+mrxak3QREssxC8CB6WVYK/2Lma9uXkiIZDhnA/+qMPT0fY2r4bE7fjFsMcslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365404; c=relaxed/simple;
	bh=+Mc1XOKwygNzl+J75JzAnRhFTS1rDyHjsKiXZ66NZo8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MZeJs54NEzGxOPlEI/1Mc4IZJomI2Q9mDbXHLr1ckhEk1KeX5UvjjwWScco0zUWorGKEwskGqbub7CyGXZw01MCTMUJWxxC9d9sYCQTRsuzgeoOdyu1GoSH6fnC1mR6KEDKh0Drn+PGBogBcX/Ug1WNQjvNMZ/m1CtCbA2vX9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZngAeNPs; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739365380; x=1739970180; i=markus.elfring@web.de;
	bh=UhVHuDHyu/BxGMdq3OfR7GfxXgzLgEBeqCkCRiMEaAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZngAeNPsGmfh2V2NCCDFKLgY2b2/CRp/qVQNY7ScrR3Yw+vQ4IFxxh5HypwU/uZI
	 x96EUUXKpYshPIoihIrcg6wxctVxdTEX95m8d82A1bdvUT1tCYAcSPV2VmfdoygXV
	 T19bTeVT/KsCKd2HFQUIaJ1QM7gvwi9QZ/5nulOpvekaOJ7kKd3qWeiM5otfOhnGm
	 ggKdEQPKpz2lHVVOY62Kfz53zHHU+JpxNLPyY2V2C6tclDkyk9O65hHRvQW7qPJXz
	 kmI11GHDd7e4ODKZdv+r2N8ROciyAcGjmSyyXRyPRDS0vCJNyIDKg2Qyvf5FATfFR
	 4pjvEofqsg6GhyiVDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR4D-1tPhhZ0GMn-00wHo8; Wed, 12
 Feb 2025 14:03:00 +0100
Message-ID: <612ab8e6-a712-41f7-ae7f-7bdc0e3c1b90@web.de>
Date: Wed, 12 Feb 2025 14:02:58 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wentao Liang <vulab@iscas.ac.cn>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Tejun Heo <tj@kernel.org>
References: <20250212083203.1030-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] block: Check blkg_to_lat() return value to avoid NULL
 dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250212083203.1030-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oku5XT0L9VHT9UFRSvoG+4mbuVUZMifD03n2hUg0w+6+WPGrNAP
 Xc/Wbq87YEsS0LU84nPcZYuTW1WT9/t3F9NgZDbVsjz2Hwsd7atkKN5uqtzVK5NCLA+uhz4
 leeRuhTgcsVWIPuZOkwFAWXYw+gZKn/7tKMn/HAyWOp6saYqAy3I+giefqXhK7N24gH18BU
 RFUNqC2ZNdf4CfkFZ25Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Br8sEHTNNaU=;7Y7yedgzvBUlld/sjcV0dPcHaOM
 7HNJxMyDRZFkPzc5REL5/tjhqNf4HJeBRJCC2DxMgC559YqNeoVtkRMfeBcP2GsAVtezymQ8q
 Hwe6fexjRkFzTQxoRbJAfcxNMBjOtGwrveenPm+wEJ/WONr5yqLRcjbF8i4OPOWzgJQ5PjgHA
 3B8QNxe4sSjd0VeUdvWCRzwwEYWNOzOkA8RrQxOvE08wdGMMkx3ysd1uhjG3SJvIdkMj3NnFs
 +gRmLXv02iC5sO3KxXFaArPzxX5V+BTAb3lOEP8L1K5TMvXK+oMj3lFxdQ5x9Pv1AgUahE/3x
 /ki6YUC76RWPfJj3/f9IOrdPC5Hq2Rmg2nH8IQzkMr0Te0GmLDtfzOhxhe/rOKGPerGG/p6e5
 /9d7Y6R1XtGs2M81vEvcU8qZjlB5Fvi10zQQsB69SUf2KX1fxT+rcvgvZHRMlzRcY83NXV1k4
 rcnJfDPfSWmQY8reF15Y4MsWTRNnrLo/BQH/2M1FrRxw4deTIMVsM4fdUHP8eJploh7epLz9B
 J17DEVUTliDQNcpvCrSGYUYi3xhXUPxeXEKwKBvTtlEdhoDJy6P3FqwFM5RePsn5HbTbVXTmb
 s2SfytFSn+TAbtJ+RaUpgkMmvj5TrgkUtnQzSw63rk2JTvJsBQvcb0FyONX1CtdRhfjxap8lu
 NS+Y55WQuDnW4u6GulUC9NfU/iChLbbIXMkxnImXdyqK+wLN38N7GKPyDSGLimF8sS23+EBK/
 5mu614v9feRwrLSoCBpijCnTyoIYuIZCdFhIiYY3c0sKwPMiXl72Wvm70x4y2f3WUNOtBi3bc
 nmFT9RJNdnBxK7rQpvZSKrXLXkF6Klmwvl2ZQhhBvAd4WtQ6MG42Z/V3rDtOtolm9ZgvB7osu
 aYkRBRrO0jLkJA3i6ki9PcuKvtkUNc0tmE64mICv7MTYRdzPQJIDpB8beeCFq9A/H8k1lHBuk
 SMZFDsgl+GyMKOSQJql85YAoXBzl9rBm0t8+XVsEb6Srcpw8WJUsqQrSstrEvtUYR4go2bD49
 0usK+I92gQUI1+RAY3Ca+fNOfv1vixylTYcSpwapi0qHx1mBqwzoTYmzKoEX0QVupOr/xS9q8
 rOULITCLT5prF5a0ANHeWIiPRSIEFpSjYvB/vMlQ7nQR98xSZJ+s3EEQybycrQDMyLrK16t2u
 Ton7UNVbFbn3DRDl19BROFlYnx1EXpDOqdjdFDAfPJPCi/qas7f7T7fjhdhUq6z/EmalmyAAO
 v5M6QLELytl4UrGP04OebNUXXIrbHdJw+zbkHJeNQuKxkjvNv/GOWx9bx2UXLtMolPl4Fkenb
 dhGhAcRObIVhSfwoWw9TGrQcZjc1fnKV4lBVz2kOXO30eOvm+nGf3MfpT/WTTpxgh90iTQ01Y
 nxUcBLgxy9wLyGgDVW1evOvWcHogikcGFDGJxkYObAfFVayvxzBj6AlaDCC+HZTi/svDZNP87
 FamWEQvOrlV04zSmdBtJg+lGRk1M=

=E2=80=A6
> This patch adds checks for the return values of blkg_to_lat and let it

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc2#n94


> returns early if it is NULL, preventing the NULL pointer dereference.

  return?


Regards,
Markus

