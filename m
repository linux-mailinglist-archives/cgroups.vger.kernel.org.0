Return-Path: <cgroups+bounces-3141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CD9021A8
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2024 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197071C20E6D
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D4811E6;
	Mon, 10 Jun 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Rkh5jNcX"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F127FBA8;
	Mon, 10 Jun 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022607; cv=none; b=q0E9z5DX8sK3oE62OPzUpK2e0VPCFekXmAm+cx0oBdgWGgmGBc+6D2Yd6jpB1nswAGGBnOmkRzyhlMcmIRZv9iPmKj37BrY4urS0pYM0Z3/8jnZqbkwqJP+RqdgjkWi6woTM270Ub5fH0ddsCzMr8LYm4JwazJxZM1GqvbvnOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022607; c=relaxed/simple;
	bh=wuJQnRYB08ec6imUGRWGaKR53UgTGv9ukbD4T7WaEcg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=f25W11wYbTzselwFyPXoHIzMfJG7zb+cTf1KF+XZ3Uj7XyMevq3DrXhL1DaTaYe17jdVDhmHjqmoPWFTN39a7s5ZAJd5Z/dVKxzMxkf/EyDO+6fHYkOYa3s7V9nkT01ef90RU21uflQFPWWsI0pwzgbhRxUfOoyOrPyRnNaOQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Rkh5jNcX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718022496; x=1718627296; i=markus.elfring@web.de;
	bh=D4Pv1t+P1y3mZ1KhtEA6vVUjt5e+QyYarpSPtOTxoLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rkh5jNcXIXoQTjWnF6EkIqPHSsd48v0//cmfBxu1+bDZPMtAUHbqywfNA5GmV37e
	 Vo/YkHNlNCXLLhSwga933B8KPm3H5stqJb8jxs+XcGvgyh40zAcwD4lVsgLEYc0HY
	 /SRvp4mbUqX8lKWX7yExtG5Pt4oRZwN5zQSppOBcAC1CZF0baXXR2YCmAULoJ7naW
	 aovi2mfS8PE8MDER3bMTnldBjUmTNYWH6kJHgZ2WWcjm1MW4p59n7s6LLJBDaxSTi
	 odIf7xa77dFD/AM3vIVIuWlGbloqbbO63/AMZiHhL0VqSWcnLMfOeVhx3PQBd8TWY
	 fl7l94Qn3UO3NMmmGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvvy-1rpb3S1aOA-00K8Ks; Mon, 10
 Jun 2024 14:28:16 +0200
Message-ID: <f8dfa410-bce0-48fe-b3d1-19fb5f5768a8@web.de>
Date: Mon, 10 Jun 2024 14:28:07 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ridong <chenridong@huawei.com>, bpf@vger.kernel.org,
 cgroups@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240607110313.2230669-1-chenridong@huawei.com>
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240607110313.2230669-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fmuK/VTR2YmSFLF2VDqjJtmVhTUzsI5l3pGMntg9UQYcsMbycmj
 +DSIdivBBL62ghxa3h9pU+c/GSmkts8QTF+2OvzfenG91FB8OSkKyy8xMktKwS/8zT6LFpw
 RT9znp2Zi6CxM09H1KMHHXuz4xWj/7+3Izuh/nT5g4JttQvRfWmi4QWB5Zk3agPzs02+7nq
 sYjc7gKvFhlTLyknF2hXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jIa/TUJcvPQ=;og0TU1hehFZUopo0uOcnVoVQ2SE
 3Hl8UUIUEF7aUsdg3iEOM8wuAg2C1lC/RcyRXdWbBdyXtT3M1oCs3W9fmEbRSvxclKMi1Xfsq
 K/pC07ZkhlfxkD7DGLn2PWUQW9XFt4DZ3vjZ34cufPmcworgk3twYQqkdw796tGHTqFoCWPT7
 dt3cy1XjqqYn8zypQQMnZvFLneZcZtFro+FUvw18rx5aFQi8oYiw4rbL70TKl3QfDaXsuKdYm
 z5kCE5EYV1lEqZR95mM3L4/39CGhRibzIagsnjmUmMswjkZI0MotoGE8lZpCezDB7mWAkKdRk
 g31NBO3YWVqWqSZ8cwC4qBT+DXOE9pUyw1V9WPUsbyrG9BQbgS3vRoItT26pXnQ2c9L5FGuuX
 sskWhPN4z8R0yM3XlNh5hiXBCVIa6peRtb2Ek/pb+dBI0ve+ma3JSdmUOwVorHNWEhY89obdu
 xPENgzF/tS6VPKyywwtZ4kYaNgP0XTYLQXiTmTqfDXFeUQ4Bb4DGBBtupWnPW7Sxvtu3Rn5yR
 IX9aVlBRSnI1P4CkBN9rL8pJw0V6IFccQLoxEhICfyNyiAY6BIN1KxI7uXEmxdpVeUYIfz+9B
 Mcr7aDy2AuyTBoR4X8x+yEypYMwJTY9ZCNrWfFiPWlDw+RZb6G7RR/h3NGjJp4As+069E9zxe
 MOkZPNdF/laInksUqqbw+m8zOOUuMsPHTCoTydJev9J4igwBB0aEB7srpAl822MPYlntY3+0d
 wkZ0D/w0DvCpjQBGO9ajL3dTczP9fSMOYpylFNLwXj1XVwsW7kPgxKTPy+0DtPRjZrG9oIwtk
 Lus04zZxyMBp/DboVtZp7cJRZW7ZE2eUtDZTitw0xA5CU=

> We found an AA deadlock problem as shown belowed:

                                           below?

* How was an =E2=80=9CAA deadlock=E2=80=9D problem detected?

* Were any special analysis tools involved?


=E2=80=A6
> preblem is solved.

  problem?


Regards,
Markus

