Return-Path: <cgroups+bounces-5621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C668F9D1832
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4811F224CD
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3111E0E16;
	Mon, 18 Nov 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="Q4kjvStg"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED641E0E12
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954676; cv=none; b=fXvtO1+W4LHUA0BNYkt48dzSNUzoQZNFy0kOEKb1YNL1RteLvbYc4hz4nOochgavPMc9x9yVrtomWbzW7RuC1xvxj8sffdi1xfncxgf6N+LXdXKwvGXlsLAfrG9Ifea7+KBHl8nQCVsRUpFNJ5GeMDo7tbh93oakoBHODxkw1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954676; c=relaxed/simple;
	bh=vvvIgPgritF4ezkA0Y8IP/3MZjF91QLJgt72ih/qwDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNYtIF4DkLTGuBPijIqdldXrQPLbyeKTjHntR9GdeZGM1Xya/8JABfAZ0C3P/eqv2FXD48uBlTkcne21rRKN3xA0NQ+FQDF5pqe+uLIFKB+B9pghaFThSOpW/bf2fhvMmr6rVoBYlG92SCstbxGg5bZr7AurxSqWdZ7VmG3OO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=Q4kjvStg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731954669; x=1732559469; i=toralf.foerster@gmx.de;
	bh=vvvIgPgritF4ezkA0Y8IP/3MZjF91QLJgt72ih/qwDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q4kjvStgj0BaWRE7imO9zaH8EUEsUCGlTjUkrRAXEQSMBl1ftFbL0f2f8bnltrAP
	 0ncgCgSMUEtnByBSwdunJoE1ur3rb+Awndo3vPqzFAcJa2X6c7pZFFPLFijxXynP2
	 4xtw7caD354XT02MWci9rzEeggcUux6K828XiNLkscLauE+eJ48nFIV6nAK4ee3ug
	 QM/38Ce+cXJab1PxTGUMvGImRLgawU3NDpywjmKVcEtVZmzgI2StMy3Z6h94YsrO4
	 qBjXA4AdvMYlRDTtAbXLFw44PlXzZPEHHv5rZ2FTO4wXhNaPN4mVsjQA8yQ2W4HBx
	 7hTotB1en68xH+Ga3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([95.116.18.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1td7fg1xeD-00kNU2; Mon, 18
 Nov 2024 19:31:09 +0100
Message-ID: <8ee3cd66-a94d-4f4d-afa5-d874d00b369a@gmx.de>
Date: Mon, 18 Nov 2024 19:31:09 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: process running under Cgroup2 control is OOM'ed if its stdout
 goes to a file at at tmpfs filesystem
Content-Language: en-US
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
References: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>
 <tuvclkyjpsulysyz6hjxgpyrlku5zuov6gyyhjzvadrqt4qpse@bwmb7ddutwzj>
 <c77e4607-6710-4256-9aac-26251813450f@gmx.de>
 <ro4p7iarm43po64rkfy7l7mpqncelmoyztwchf6zdcnqerwbm6@z3ubeedjvcbo>
 <caee0ba5-b223-4d66-8db3-4a12ac8156d3@redhat.com>
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
In-Reply-To: <caee0ba5-b223-4d66-8db3-4a12ac8156d3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:92dPe1SbGl8TeaZRxNhLff9TH/Jf3qpQbQdw/ZMC33CPbBlNu4h
 iMdZQqnefDFiXFI67OCrrVm/lXPYPcwjbBUj5gkEXYXSP5SxRE2Iy/LLg7w7PUeAZFLbCEf
 w6yhsEGzbXrDAYY0nN0mSC1RbFkRXCUFssj6DXg+ZfzZNi30FczNs1a3slQ6Ky3FnW/OI49
 Gt+pwb1BNxk11qBxn07+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uqXBYkD1JCo=;r2ttCrbQ2h8AaqjeIqg660GAXk9
 n8x6gEyJ3tZahsAVvMBcFHYgISOOQ9Ed6Guqr7AfGWDid3Zo9rG80LjKb64Q0/8fHTnSoeUTB
 LZ4eEuvAPVaO8pTbZDfMPQFYX3ZbmsReNNd/r52vsUjNX7LaI9gTgmncV2uBb4svedKVycbR7
 nYo0ex/nHGB1wIqcbdN92uocSeXPpRnToNBAsJoeHBNVDBunXBNEQDWjGSOp+z9gr7RPyUYmm
 HffIhR6bXy2Od5rq0bXPjEfiKskcYQsx9gO/W9rlfYsQBpBHiBZmmcPYCQjQ4cOnva4CxOTBA
 VzUtMlLkuJhTi3fqUJIy9BA6y5vymOeoLaMR8zcn01//JjIY0acfQpAzjg8j2lTAUV+ZmPosn
 JjkjfItAhJ/fe/53JX0p6RyrZKvetpygNbrRQK3nYKvV9eV2krkbPBcNOqM69i49vjLaJp8Wg
 j7t6ksXqCrdeTK1CWRAOAXOzdRtKkoLJyHyE7DVuvxb6EErLrRNp/YzrvrEPmWGnABQyZqYAE
 rE6lQPuVhNe0vQAkxvs/4tWjOc8msx1h2MhtNA29N0aetm9AB8bSTAslvVaxavGTSR8DZScMi
 nW/M2Qf6xr0GjTH80yvDcc2GXcliNME3zh5q7IcljHomZ8HUUCHoVC12LF/HhEICV7PXH6KCY
 7Mmwd9Vvo+80K3DRbB27bUIUjT3TgbHXWLHcMYGMx6NO35+EU5OBlOO3oi2zYh/siYUpQ8nGz
 +zziueb0ZKm11L5jW+Nnf8ejKQaV9Ny62LrIp7CBb/2ThHUU9o7j7UhtP84/Wm9rULXdgABzo
 UOYrSsLY06z7yKHjMs3HPsAlsBLU7EE5U3DtV/BQ6Lzq6GRPKb5zhyCPPaU8l0J48j/8CTw1j
 5ZaYbd3JlrDKYC6PvJOF03JoCZ4fbv7emPKeIAlG5PNOR04i/dHSOb8Wc

On 11/18/24 18:07, Waiman Long wrote:
>>
>> I'm=C2=A0not=C2=A0sure=C2=A0that's=C2=A0the=C2=A0answer=C2=A0you=C2=A0e=
xpect=C2=A0=C2=AF\_(=E3=83=84)_/=C2=AF
>
> By default, tmpfs sets the filesystem size limit to half of the
> available RAM. So unless the the processes in the cgroup also consume a
> lot of memory besides those for tmpfs, tmpfs write error due to lack of
> space=C2=A0will=C2=A0happen=C2=A0first=C2=A0before=C2=A0OOM.

Well, then it should work.
( I do run build bots for Gentoo and fuzzers at this system. So my main
goal is to ensure that neither a build bot nor a fuzzer is harming all
others. )

Thx you for the clarification.

=2D-
Toralf

