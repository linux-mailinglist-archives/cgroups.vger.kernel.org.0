Return-Path: <cgroups+bounces-17691-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3C3tAsSoVGrrowMAu9opvQ
	(envelope-from <cgroups+bounces-17691-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:58:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0CD749083
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=U5P9xbLd;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17691-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17691-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA9FC300EE9F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DC3D5C0B;
	Mon, 13 Jul 2026 08:58:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11F3D6463
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:58:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933120; cv=none; b=hzFJw7ZAVSoenGqwF/OVekzAO232moH/+oj7D7zpZnRjVa1JManXLu6zOHjyj8rLk4bW0eR3zct9WroRRnV2SEFm45CWRzGcKVWjPaSHtdYvyV15gyf7h44p1AsUyYvCAacgC08rrx1Db+4+TWQwa3/dFdfhB1ccPRWmANLKwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933120; c=relaxed/simple;
	bh=1o1CyI5Ge8COlJA/GNtWMVlB7gFYnNefBLUngEwwR3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd2p5vgs/JHe4IsFZ3H2M8W6aH2J2nlypLTWq6lVl2eUGQZy1KB90XEIa4GmL1dyz8TB9l2t2N/Kf7DmMGiyMeCMZkkJG6/rNWq5BuK1Bcr50Nmp3d7nyUYlg8YijKXiA5Isz8SnhsWnx1EBGqeanlLL84SonCpASRFyFGlb/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=U5P9xbLd; arc=none smtp.client-ip=209.85.167.48
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b018fe8318so2083385e87.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783933113; x=1784537913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VAR/B1mlsTXa8tBE6zzVojx+J5Qr4ZE0aQH3nd2YxMA=;
        b=U5P9xbLd+WKkHG7aivFZ2Y6ZO5n5wy1d0fNdWq7zcT6fmyvWY4Spe+a/mZqFBSZU0b
         COGhPIl/ay+d+R20Tz3SAS9iayWppR97YyF1laL+D1nUViNzo1Q17pwTEa58GI0bWwL/
         641lm+TukMRewa6shRu+kWUO/IKLxEO+sNHd+vn4erBPi1gKYVdtNTAC/3xwgwMnLSxA
         LYjpk1A+i8a3dAEcJ0mNkuF9QY0s7yKC8M/BKJTLMyJ5WoZxTYVhHABBJpt9pEYIn9LJ
         s0wfmKNl+c5u8qppxUjA/Nd05KCkw5JjlHB75CtoBADii39PGIIXL7816utX0ukmuOfo
         kZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933113; x=1784537913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VAR/B1mlsTXa8tBE6zzVojx+J5Qr4ZE0aQH3nd2YxMA=;
        b=D05buUrbdigacVpWHkOgceYn6+8jFQrGftOKE/AvIaLJrvUrUdv+g5961nV6mB51S2
         lyhiJ1P15I7jMk7eJ4AE1iPIlvMJjCa5q7LWRYDrHCnaQ7Zvfx6XCuHSWGghExg0qMo9
         RTpkXNumCvFwjixYjyy/d114rasg0OyWUx+1y59KnWe9Sy/ouv0DbeWvYoy5vHfDrGFA
         hrWj5ABlGznf7x+CoqUz6OaAXHa2/5Tl3YAiWCxSftXliD3Mnnr39PiDDWiI8x2Bx+sy
         WLmqhz7uarR5bStBMvMSNWmpmpHMKW66p3weFnl2sTESqKkFMZtLoAm+S6uiRcE8hQmA
         Gkiw==
X-Forwarded-Encrypted: i=1; AHgh+RowN0bAZvY9uDKyN2PKWIdhGSCkQmxV2mX4xNbmbTXYR6U9ONVV7EHeSUTrDzAhxKA4cxKNGVjI@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiBZGPkKu/L2FJQFgKah8NNVT1uJKwZyCwnOtmHPvY8K6fKu0
	1Hr6btq3tK27qaC40PJSoFz/Jx4rEcLnWCsULv5rcpjztZImsHgDWDYv9tXB8UkKOSA=
X-Gm-Gg: AfdE7ckmDa08qhMJXlrl30OE3DRKqpeqAmlmN511Tcjrz+KttQfwRaZnO097ZMcghFU
	cIfIAWAAJCFqtQu6u3oZm2gA0x3yKjxj3jju7/gWiOVHP93KKKKU0Dlu663SVhNm3M94W/gz8Z8
	mk8o29sACo1Wl4J0YVBwgZam1rk7k5q37IiYI/zi/sEx+ykWbsp9+6O4XnooaaqMfgOs/k+6t59
	9+eUXslfEY+AzMV5pQLu2b/in6uedgzu5JZYxpQFLUhvLbPxHKQxa+ZR4GxM5cQBo7Tmxwd0f2d
	5+nl7BLe+zoyJQA40DYxcyD1wOlqXUhVIvHAW0wzhg6fIulQ1xA6Vc+iW5h56CFW2jiFQ0m5sSw
	URSvKH30TfBVS6TSefJVLJFp92bfGhJntb4xHg/ZhjiFtUN3ptlcmkNIty0UnDDyI7kStMikJNF
	PcDj6uEHfSJC8UNUHwYm98olk19RQV0JhQ
X-Received: by 2002:a05:6512:1194:b0:5b0:12cf:ae18 with SMTP id 2adb3069b0e04-5b0236ade52mr2002807e87.47.1783933113266;
        Mon, 13 Jul 2026 01:58:33 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caa5c4csm2737736e87.57.2026.07.13.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:58:32 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:58:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jgg@ziepe.ca, leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	cmeiohas@nvidia.com, roman.gushchin@linux.dev, bvanassche@acm.org, 
	zyjzyj2000@gmail.com, shuah@kernel.org, tj@kernel.org, mkoutny@suse.com, 
	hannes@cmpxchg.org, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com
Subject: Re: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names test
Message-ID: <alSoo59MP6b34Uk8@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-14-jiri@resnulli.us>
 <ebb4125e-6d35-44c9-b1b8-267dc3226b81@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebb4125e-6d35-44c9-b1b8-267dc3226b81@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-17691-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E0CD749083

Fri, Jul 10, 2026 at 06:24:25AM +0200, yanjun.zhu@linux.dev wrote:
>
>在 2026/7/9 2:55, Jiri Pirko 写道:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add a kselftest script that exercises per-netns RDMA device naming
>> with RXE. Cover duplicate names across namespaces, move conflict
>> handling, move-with-rename, and same-namespace rename requests.
>
>This is a very comprehensive test suite for the per-netns RDMA device naming
>infra.
>
>I especially appreciate the inclusion of the 'TEST_TEARDOWN_RETURN'
>case—ensuring
>
>that the kernel's automatic renaming and fallback mechanics work seamlessly
>during
>
>netns deletion is crucial for long-term stability.
>
>
>One minor thing to clean up before pushing to the tree: the script declares
>'ktap_set_plan 7'
>
>but actually defines 6 distinct test cases in the execution block. I will fix
>this plan count to 6

Correct. Leftover, will fix.


>
>to avoid any "bad plan" warnings in automated CI frameworks (like KernelCI).
>
>
>Aside from that, the cleanup paths and setup tracking are solid.
>
>Thanks for adding this.
>
>Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>


Thanks!


>
>Zhu Yanjun
>
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   tools/testing/selftests/rdma/Makefile         |   3 +-
>>   tools/testing/selftests/rdma/config           |   2 +
>>   .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
>>   3 files changed, 286 insertions(+), 1 deletion(-)
>>   create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh
>> 
>> diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
>> index 07af7f15c1bf..a91c14c45006 100644
>> --- a/tools/testing/selftests/rdma/Makefile
>> +++ b/tools/testing/selftests/rdma/Makefile
>> @@ -3,6 +3,7 @@ TEST_PROGS := rxe_rping_between_netns.sh \
>>   		rxe_ipv6.sh \
>>   		rxe_socket_with_netns.sh \
>>   		rxe_test_NETDEV_UNREGISTER.sh \
>> -		rxe_sent_rcvd_bytes.sh
>> +		rxe_sent_rcvd_bytes.sh \
>> +		rxe_netns_names.sh
>>   include ../lib.mk
>> diff --git a/tools/testing/selftests/rdma/config b/tools/testing/selftests/rdma/config
>> index 4ffb814e253b..e1ff54ec0f57 100644
>> --- a/tools/testing/selftests/rdma/config
>> +++ b/tools/testing/selftests/rdma/config
>> @@ -1,3 +1,5 @@
>>   CONFIG_TUN
>>   CONFIG_VETH
>> +CONFIG_DUMMY
>> +CONFIG_NET_NS
>>   CONFIG_RDMA_RXE
>> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
>> new file mode 100755
>> index 000000000000..a7e57706fdff
>> --- /dev/null
>> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
>> @@ -0,0 +1,282 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Exercise RDMA device name handling across network namespaces.
>> +
>> +source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
>> +
>> +NAME_PREFIX="rxe_netns_names_$$"
>> +NETDEV_PREFIX="rxn$$"
>> +NS1="${NAME_PREFIX}ns1"
>> +NS2="${NAME_PREFIX}ns2"
>> +RXE_A="${NAME_PREFIX}rxe_a"
>> +RXE_B="${NAME_PREFIX}rxe_b"
>> +RXE_SAME="${NAME_PREFIX}rxe_same"
>> +RXE_NEW="${NAME_PREFIX}rxe_new"
>> +DUMMY_A="${NETDEV_PREFIX}a"
>> +DUMMY_B="${NETDEV_PREFIX}b"
>> +OLD_MODE=""
>> +MODE_CHANGED=0
>> +MODS=("dummy" "rdma_rxe")
>> +TEST_SAME_NAMES="same RDMA device name can exist in two net namespaces"
>> +TEST_MOVE_CONFLICT="move without rename fails on destination name conflict"
>> +TEST_MOVE_RENAME="move then rename succeeds"
>> +TEST_COMBINED_MOVE_RENAME="move with requested destination name succeeds"
>> +TEST_SAME_NETNS_DUP_RENAME="same-netns rename rejects duplicate name"
>> +TEST_TEARDOWN_RETURN="netns delete returns device to init_net and renames on conflict"
>> +
>> +ksft_skip()
>> +{
>> +	ktap_skip_all "$*"
>> +	exit "$KSFT_SKIP"
>> +}
>> +
>> +fail()
>> +{
>> +	ktap_exit_fail_msg "$*"
>> +}
>> +
>> +need_cmd()
>> +{
>> +	command -v "$1" >/dev/null 2>&1 || ksft_skip "missing command: $1"
>> +}
>> +
>> +rdma_ns()
>> +{
>> +	local ns=$1
>> +
>> +	shift
>> +	ip netns exec "$ns" rdma "$@"
>> +}
>> +
>> +rdma_dev_exists()
>> +{
>> +	local ns=$1
>> +	local dev=$2
>> +
>> +	if [ -n "$ns" ]; then
>> +		rdma_ns "$ns" dev show "$dev" >/dev/null 2>&1
>> +	else
>> +		rdma dev show "$dev" >/dev/null 2>&1
>> +	fi
>> +}
>> +
>> +add_dummy()
>> +{
>> +	local netdev=$1
>> +
>> +	ip link add "$netdev" type dummy || return 1
>> +	ip link set "$netdev" up || return 1
>> +}
>> +
>> +add_rxe()
>> +{
>> +	local dev=$1
>> +	local netdev=$2
>> +
>> +	rdma link add "$dev" type rxe netdev "$netdev"
>> +}
>> +
>> +rdma_dev_on_netdev()
>> +{
>> +	local netdev=$1
>> +
>> +	rdma link show 2>/dev/null | awk -v want="$netdev" '
>> +		{
>> +			for (i = 1; i < NF; i++)
>> +				if ($i == "netdev" && $(i + 1) == want) {
>> +					dev = $2
>> +					sub(/\/.*/, "", dev)
>> +					print dev
>> +					exit
>> +				}
>> +		}'
>> +}
>> +
>> +wait_rdma_dev_on_netdev()
>> +{
>> +	local netdev=$1
>> +	local dev
>> +	local i
>> +
>> +	for i in $(seq 1 50); do
>> +		dev=$(rdma_dev_on_netdev "$netdev")
>> +		if [ -n "$dev" ]; then
>> +			echo "$dev"
>> +			return 0
>> +		fi
>> +		sleep 0.1
>> +	done
>> +
>> +	return 1
>> +}
>> +
>> +setup_devs()
>> +{
>> +	cleanup_devs
>> +
>> +	add_dummy "$DUMMY_A" || return 1
>> +	add_dummy "$DUMMY_B" || return 1
>> +
>> +	add_rxe "$RXE_A" "$DUMMY_A" || return 1
>> +	add_rxe "$RXE_B" "$DUMMY_B" || return 1
>> +}
>> +
>> +cleanup_devs()
>> +{
>> +	ip link del "$DUMMY_A" 2>/dev/null
>> +	ip link del "$DUMMY_B" 2>/dev/null
>> +}
>> +
>> +setup()
>> +{
>> +	OLD_MODE=$(rdma system show 2>/dev/null |
>> +		   sed -n 's/.*netns \([^ ]*\).*/\1/p')
>> +	[ -n "$OLD_MODE" ] || ksft_skip "failed to read RDMA netns mode"
>> +
>> +	rdma system set netns exclusive >/dev/null 2>&1 ||
>> +		ksft_skip "rdma netns exclusive mode is not supported"
>> +	MODE_CHANGED=1
>> +
>> +	ip netns add "$NS1" || return 1
>> +	ip netns add "$NS2" || return 1
>> +}
>> +
>> +cleanup()
>> +{
>> +	cleanup_devs
>> +
>> +	ip netns del "$NS1" 2>/dev/null
>> +	ip netns del "$NS2" 2>/dev/null
>> +
>> +	if [ "$MODE_CHANGED" -eq 1 ]; then
>> +		rdma system set netns "$OLD_MODE" 2>/dev/null
>> +	fi
>> +
>> +	for m in "${MODS[@]}"; do
>> +		modprobe -r "$m" 2>/dev/null
>> +	done
>> +}
>> +
>> +rdma_supports_combined_move_rename()
>> +{
>> +	rdma dev help 2>&1 | grep -Eq 'netns .*name|name .*netns'
>> +}
>> +
>> +[ "$(id -u)" -eq 0 ] || ksft_skip "must be run as root"
>> +need_cmd ip
>> +need_cmd rdma
>> +need_cmd modprobe
>> +
>> +trap cleanup EXIT
>> +
>> +for m in "${MODS[@]}"; do
>> +	modinfo "$m" >/dev/null 2>&1 || ksft_skip "module $m not found"
>> +	modprobe "$m" || fail "failed to load $m"
>> +done
>> +
>> +setup || fail "failed to create net namespaces"
>> +
>> +ktap_print_header
>> +ktap_set_plan 7
>> +
>> +if setup_devs &&
>> +   rdma dev set "$RXE_A" netns "$NS1" &&
>> +   rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" &&
>> +   rdma dev set "$RXE_B" netns "$NS2" &&
>> +   rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" &&
>> +   rdma_dev_exists "$NS1" "$RXE_SAME" &&
>> +   rdma_dev_exists "$NS2" "$RXE_SAME"; then
>> +	ktap_test_pass "$TEST_SAME_NAMES"
>> +else
>> +	ktap_test_fail "$TEST_SAME_NAMES"
>> +fi
>> +cleanup_devs
>> +
>> +if ! setup_devs ||
>> +   ! rdma dev set "$RXE_A" netns "$NS1" ||
>> +   ! rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" ||
>> +   ! rdma dev set "$RXE_B" netns "$NS2" ||
>> +   ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME"; then
>> +	ktap_test_fail "$TEST_MOVE_CONFLICT"
>> +elif rdma_ns "$NS1" dev set "$RXE_SAME" netns "$NS2" >/dev/null 2>&1; then
>> +	ktap_test_fail "$TEST_MOVE_CONFLICT"
>> +elif rdma_dev_exists "$NS1" "$RXE_SAME" &&
>> +     rdma_dev_exists "$NS2" "$RXE_SAME"; then
>> +	ktap_test_pass "$TEST_MOVE_CONFLICT"
>> +else
>> +	ktap_test_fail "$TEST_MOVE_CONFLICT"
>> +fi
>> +cleanup_devs
>> +
>> +if ! setup_devs; then
>> +	ktap_test_fail "$TEST_MOVE_RENAME"
>> +elif rdma dev set "$RXE_A" netns "$NS2" &&
>> +     rdma_ns "$NS2" dev set "$RXE_A" name "$RXE_NEW"; then
>> +	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
>> +	   ! rdma_dev_exists "" "$RXE_A"; then
>> +		ktap_test_pass "$TEST_MOVE_RENAME"
>> +	else
>> +		ktap_test_fail "$TEST_MOVE_RENAME"
>> +	fi
>> +else
>> +	ktap_test_fail "$TEST_MOVE_RENAME"
>> +fi
>> +cleanup_devs
>> +
>> +if ! rdma_supports_combined_move_rename; then
>> +	ktap_test_skip "$TEST_COMBINED_MOVE_RENAME"
>> +elif ! setup_devs; then
>> +	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
>> +elif rdma dev set "$RXE_A" netns "$NS2" name "$RXE_NEW"; then
>> +	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
>> +	   ! rdma_dev_exists "" "$RXE_A"; then
>> +		ktap_test_pass "$TEST_COMBINED_MOVE_RENAME"
>> +	else
>> +		ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
>> +	fi
>> +else
>> +	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
>> +fi
>> +cleanup_devs
>> +
>> +if ! setup_devs; then
>> +	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
>> +elif rdma dev set "$RXE_A" name "$RXE_SAME" &&
>> +     rdma dev set "$RXE_B" name "$RXE_NEW"; then
>> +	if rdma dev set "$RXE_A" name "$RXE_NEW" >/dev/null 2>&1; then
>> +		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
>> +	elif rdma_dev_exists "" "$RXE_SAME" &&
>> +	     rdma_dev_exists "" "$RXE_NEW"; then
>> +		ktap_test_pass "$TEST_SAME_NETNS_DUP_RENAME"
>> +	else
>> +		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
>> +	fi
>> +else
>> +	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
>> +fi
>> +cleanup_devs
>> +
>> +if ! setup_devs; then
>> +	ktap_test_fail "$TEST_TEARDOWN_RETURN"
>> +elif ! rdma dev set "$RXE_A" name "$RXE_SAME" ||
>> +     ! rdma dev set "$RXE_B" netns "$NS2" ||
>> +     ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" ||
>> +     ! rdma_dev_exists "$NS2" "$RXE_SAME"; then
>> +	ktap_test_fail "$TEST_TEARDOWN_RETURN"
>> +else
>> +	ip netns del "$NS2"
>> +	returned=$(wait_rdma_dev_on_netdev "$DUMMY_B")
>> +	ktap_print_msg "device returned to init_net as '${returned:-<missing>}'"
>> +	if rdma_dev_exists "" "$RXE_SAME" &&
>> +	   [ -n "$returned" ] &&
>> +	   [ "$returned" != "$RXE_SAME" ] &&
>> +	   [ "${returned#ibdev}" != "$returned" ]; then
>> +		ktap_test_pass "$TEST_TEARDOWN_RETURN"
>> +	else
>> +		ktap_test_fail "$TEST_TEARDOWN_RETURN"
>> +	fi
>> +fi
>> +cleanup_devs
>> +
>> +ktap_finished
>
>-- 
>Best Regards,
>Yanjun.Zhu
>

