Return-Path: <cgroups+bounces-15571-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPljExbK82ma7AEAu9opvQ
	(envelope-from <cgroups+bounces-15571-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 23:31:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79F4A833F
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 23:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A75083014663
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7F3B2FCA;
	Thu, 30 Apr 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UeV+B5Nq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAA39C637
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584644; cv=none; b=ecotQ3480Z+Y9mwmG3fGijXPmO4GezIdxida+pkYXQ+KLJnqNdzLlEChQNIWLpBDj0j04vHjWmvHT5gbMN+16BAShO48rTyvpNHzHVeEAcvEH+cM7pmnEvBSb6+Bx41BSrX/1IAFtB50obRetVmDcIXmiQDxY88bykeebqtoI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584644; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DdBiin22hnoSWkCrhNA2HAgG7KPX7Wf6KV60pRg6MT7IaR2FT51J8GlKOz7T9oq6D8g93BO0AdPstlD2ULjIRgFqKedUf+zK7jDfzXrbaMyb0jVRxh2g049MCyxc6+D/5iKFs0lGBSXR7Zpyz7osdzDG5WRIZqWere+o8411ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UeV+B5Nq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UI9iFe1988387
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvc458tc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ee34588671so656241eec.0
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584641; x=1778189441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=UeV+B5NqiCZ/BrFv0CvfbpPzVZQ86lsYxKf4hOOSM5SIVWZtzfUI6P5HqNvtbyG/rB
         agi/3g6jUssY+cpiirMKM+luydqqrlO49iEDyQqXj/ein/yWTUFJz2cG0MGDg4M6NXrJ
         ZVU3MnU8ls1A2DKFZaf52TzwZBci8k9zscVKvViafw5abb0BV4IBECuQShC7nF3f3H9T
         rs6lj02yBk/bSSGL/02yoPaR18wVY7bZXdEAuIwemUDcjs3mFR8P2Ko5RQfrzC+AgZ6/
         GxdPGT30+zPeMYFx4cUhfVvBXcp2kGCEu1JKbKIJIkzEIJ/UWa9vSsZRoytmto3PWAvH
         qvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584641; x=1778189441;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=hzng4BGV4Wn+TNMDqDTvGA7aWihWLquagBGfLdI+PEh3kM2vaoH+P2VSN18vqYy2zl
         1rimFuzGE7+EXMCrbhYksoISgMBDB3bITDnw2cnt7Ye99Ak5tjQV5XnigUDJnPo/FnrQ
         a0DSxjdhhCpXYWWpCpcOu3MWD0M/gLw+nLkpjIC/nlZPE23+vYD5tjmIzkxpgzR92/9U
         KYRxs0VE8nCKrFKLe0rSCW7cOJV7ikTkzPpU+XnW85AJ6nArD3GgkUgSs9ekCDNV3cax
         mgmtYry3qckJOIKE0znS/Ij1ZyQ0QWZvsF4bC865NF9OZrD14HKaW2Wxp16dHhS0c6dl
         DDiA==
X-Forwarded-Encrypted: i=1; AFNElJ9Kvykg8IRRBP3TknQk6YdgBm1hN7Hn2Sf7PHwBI5OnWnGSgEFxRrMHz3Jygdq32znE1s8byiT4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YL9ahDP/qX52Qs2Ki2iPbioNXdZF1lfCAAkWUaONm2P2XrZz
	rwSPscZTXur7Y7uyyerVhSY32Az3nRX4JXH9BIJLz7dbUIoyxHFwXKc7zkVHYKagIrTjQPpSF2W
	nUS2MBks/JftMd2t0aNKZY44ndMCy2WcYlDNE49A5bWU+IMBhDKFA81k3hQhk
X-Gm-Gg: AeBDietx/T6++bSfEw1Tl4Uo6MrcpVGhW+blpILg5LGvjmdSnV6CFMhlI7JFmzHoxNF
	ysCdtjR/oZ9Wx5fz9/yzrqtQVoA2mvIyiBBAhms6fbSEw4DTuPWHUDEP5pC4T938DekczaHN85E
	c0oJrUcE3pxyglj7L4ZX/UVpCuZ8ap2VnwYAZYfjE3OCDI5NmJzAo/Ov12fYEmUIWXFBAcL/6V1
	TY2OMP/Xbzusvrnd7d+X37NuLu5+Ut4vi7Yyw7Xh30dYxnNcJ8A6biMoiZFdEYPEW5qU8luIytM
	VZRMkUaY4wOEazAPPaK0PG12K2ZUbQgedwT6lcOX0TSLoN/BkhTDl9+eV+MH3tFTL8mGLkjT+oL
	Y5J9ZyxG5C6K/FRkIOrJKS41Azhh+Rlpe8QYJzIBJB8F5lpr+rGfB4Z08DIPiX9vLb3DRkd7e9B
	Wgako47V14sDQ=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496714eec.8.1777584641144;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMSBTYWx0ZWRfX9TZvRToXeoMP
 nnq80nrhUgTMhSJ39mGSQNWi5OlCkucmJd0tmZyOwK4tm1Kb2RwJqP0OvJ0JqiMrfTLoaTdEOIm
 NIjhOfZpS45LY7XNo27bqojo4nWgIs6WmYQonJuhsM/yg3hpSZaKssPH/PvAdWq4RstjcoPMve4
 xuZ58agPnLtfCIsy7iMm2eyS/KVoVq/+Ph5Qe9GLrMGMPilLXs/2pfyJ3LBjoGJ+LoPz+3h/mz/
 GDTra8qNIi8akp65VixqWqU3yJjktvBGdgg90OuajjMmr/zTDVVjRVCZ1ras4IRnSpquZtdt7/8
 6tLsadHDqB/5Ggo/1cAJ5cV28YngFxOk5hi2Qf7ffV2c5yp89shCw3yHigvSd95FoxiJUCUOnP3
 DHOfGMEqbXpf0K/+86S9BEivXu2FBCC0akoxu5yCQysP5rtOPNxDSUILzZdwIoWMDnUsSLsO3sF
 zeH31W0XBEJn5ThoJ0A==
X-Authority-Analysis: v=2.4 cv=DP+/JSNb c=1 sm=1 tr=0 ts=69f3ca02 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 64YMC21ErZIwWddHJwbV1WkW1DKruR9s
X-Proofpoint-GUID: 64YMC21ErZIwWddHJwbV1WkW1DKruR9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300221
X-Rspamd-Queue-Id: AB79F4A833F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15571-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,linux.intel.com,gmail.com,jvosburgh.net,linux.ibm.com,kvack.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,sina.com,kernel.org,vger.kernel.org,lists.linux.dev,kvack.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


