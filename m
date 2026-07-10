Return-Path: <cgroups+bounces-17646-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dWH2Ex90UGoizQIAu9opvQ
	(envelope-from <cgroups+bounces-17646-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 06:25:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD77371E2
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 06:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LJGfn04S;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17646-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17646-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE24301DE3E
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 04:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699836C9F0;
	Fri, 10 Jul 2026 04:24:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17736AB72
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 04:24:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657487; cv=none; b=nPz7U3n2APq/nOufYPGBipnZ8Wb5I4i84XpofGAwpl26dA8F3TAmyGooqIHZsfqKEW2i/xH8tfFiOiLiOA8JXwULFPq87mRFXDAruLVqwH2RTDpH8ip/Zw84M6o3v7SqRA3Sc+wO4np1VrjDwAaQQqw+GkU6soWfVWOa7lh+Zes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657487; c=relaxed/simple;
	bh=5vGYUhOMuE2kcV5F2F/QyOUeKJT4pi9j/suBd/skgfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2GuXlr9aaazvNqZzWxD/e/A58GdbNMXuDK7/DZyDnQL5hpGROGZxxxwOsw7qw2HOtkmLqCqVwEeCIHF8xTEAWNnzTEer21MJbbFxweVWUos4Al0wDzSDnLjnbEK1CK8WGUSLNv4iMF5kcqZXcej6HGY2CyeajmcW+h7yjTtSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJGfn04S; arc=none smtp.client-ip=91.218.175.174
Message-ID: <ebb4125e-6d35-44c9-b1b8-267dc3226b81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783657473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48gm6OSOL1SSOirHXZF2Z0M3HkLWpnOs0tv5n6E0teY=;
	b=LJGfn04SGFnL8UXhLSB+52PBN7KESuIh0Km2DPDIXEWCwpVcPBjjL7pNuROWfkO3PbuKb4
	s5by1GL/2w+WeQFh6Fp0wbpSxEQCnzYDYPz5NsvnR03XOVlKjLSD4XfRhpaKmrfuJJHrAX
	kh/MORb3lQmU3ylwe47f8YvgkCuI88Q=
Date: Thu, 9 Jul 2026 21:24:25 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names test
To: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, jgg@ziepe.ca,
 leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, cmeiohas@nvidia.com,
 roman.gushchin@linux.dev, bvanassche@acm.org, zyjzyj2000@gmail.com,
 shuah@kernel.org, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-14-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260709095532.855647-14-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17646-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxe_test_netdev_unregister.sh:url,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,rxe_ipv6.sh:url,nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rxe_rping_between_netns.sh:url,rxe_socket_with_netns.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0BD77371E2


在 2026/7/9 2:55, Jiri Pirko 写道:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a kselftest script that exercises per-netns RDMA device naming
> with RXE. Cover duplicate names across namespaces, move conflict
> handling, move-with-rename, and same-namespace rename requests.

This is a very comprehensive test suite for the per-netns RDMA device 
naming infra.

I especially appreciate the inclusion of the 'TEST_TEARDOWN_RETURN' 
case—ensuring

that the kernel's automatic renaming and fallback mechanics work 
seamlessly during

netns deletion is crucial for long-term stability.


One minor thing to clean up before pushing to the tree: the script 
declares 'ktap_set_plan 7'

but actually defines 6 distinct test cases in the execution block. I 
will fix this plan count to 6

to avoid any "bad plan" warnings in automated CI frameworks (like KernelCI).


Aside from that, the cleanup paths and setup tracking are solid.

Thanks for adding this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   tools/testing/selftests/rdma/Makefile         |   3 +-
>   tools/testing/selftests/rdma/config           |   2 +
>   .../testing/selftests/rdma/rxe_netns_names.sh | 282 ++++++++++++++++++
>   3 files changed, 286 insertions(+), 1 deletion(-)
>   create mode 100755 tools/testing/selftests/rdma/rxe_netns_names.sh
>
> diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
> index 07af7f15c1bf..a91c14c45006 100644
> --- a/tools/testing/selftests/rdma/Makefile
> +++ b/tools/testing/selftests/rdma/Makefile
> @@ -3,6 +3,7 @@ TEST_PROGS := rxe_rping_between_netns.sh \
>   		rxe_ipv6.sh \
>   		rxe_socket_with_netns.sh \
>   		rxe_test_NETDEV_UNREGISTER.sh \
> -		rxe_sent_rcvd_bytes.sh
> +		rxe_sent_rcvd_bytes.sh \
> +		rxe_netns_names.sh
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/rdma/config b/tools/testing/selftests/rdma/config
> index 4ffb814e253b..e1ff54ec0f57 100644
> --- a/tools/testing/selftests/rdma/config
> +++ b/tools/testing/selftests/rdma/config
> @@ -1,3 +1,5 @@
>   CONFIG_TUN
>   CONFIG_VETH
> +CONFIG_DUMMY
> +CONFIG_NET_NS
>   CONFIG_RDMA_RXE
> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
> new file mode 100755
> index 000000000000..a7e57706fdff
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
> @@ -0,0 +1,282 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Exercise RDMA device name handling across network namespaces.
> +
> +source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
> +
> +NAME_PREFIX="rxe_netns_names_$$"
> +NETDEV_PREFIX="rxn$$"
> +NS1="${NAME_PREFIX}ns1"
> +NS2="${NAME_PREFIX}ns2"
> +RXE_A="${NAME_PREFIX}rxe_a"
> +RXE_B="${NAME_PREFIX}rxe_b"
> +RXE_SAME="${NAME_PREFIX}rxe_same"
> +RXE_NEW="${NAME_PREFIX}rxe_new"
> +DUMMY_A="${NETDEV_PREFIX}a"
> +DUMMY_B="${NETDEV_PREFIX}b"
> +OLD_MODE=""
> +MODE_CHANGED=0
> +MODS=("dummy" "rdma_rxe")
> +TEST_SAME_NAMES="same RDMA device name can exist in two net namespaces"
> +TEST_MOVE_CONFLICT="move without rename fails on destination name conflict"
> +TEST_MOVE_RENAME="move then rename succeeds"
> +TEST_COMBINED_MOVE_RENAME="move with requested destination name succeeds"
> +TEST_SAME_NETNS_DUP_RENAME="same-netns rename rejects duplicate name"
> +TEST_TEARDOWN_RETURN="netns delete returns device to init_net and renames on conflict"
> +
> +ksft_skip()
> +{
> +	ktap_skip_all "$*"
> +	exit "$KSFT_SKIP"
> +}
> +
> +fail()
> +{
> +	ktap_exit_fail_msg "$*"
> +}
> +
> +need_cmd()
> +{
> +	command -v "$1" >/dev/null 2>&1 || ksft_skip "missing command: $1"
> +}
> +
> +rdma_ns()
> +{
> +	local ns=$1
> +
> +	shift
> +	ip netns exec "$ns" rdma "$@"
> +}
> +
> +rdma_dev_exists()
> +{
> +	local ns=$1
> +	local dev=$2
> +
> +	if [ -n "$ns" ]; then
> +		rdma_ns "$ns" dev show "$dev" >/dev/null 2>&1
> +	else
> +		rdma dev show "$dev" >/dev/null 2>&1
> +	fi
> +}
> +
> +add_dummy()
> +{
> +	local netdev=$1
> +
> +	ip link add "$netdev" type dummy || return 1
> +	ip link set "$netdev" up || return 1
> +}
> +
> +add_rxe()
> +{
> +	local dev=$1
> +	local netdev=$2
> +
> +	rdma link add "$dev" type rxe netdev "$netdev"
> +}
> +
> +rdma_dev_on_netdev()
> +{
> +	local netdev=$1
> +
> +	rdma link show 2>/dev/null | awk -v want="$netdev" '
> +		{
> +			for (i = 1; i < NF; i++)
> +				if ($i == "netdev" && $(i + 1) == want) {
> +					dev = $2
> +					sub(/\/.*/, "", dev)
> +					print dev
> +					exit
> +				}
> +		}'
> +}
> +
> +wait_rdma_dev_on_netdev()
> +{
> +	local netdev=$1
> +	local dev
> +	local i
> +
> +	for i in $(seq 1 50); do
> +		dev=$(rdma_dev_on_netdev "$netdev")
> +		if [ -n "$dev" ]; then
> +			echo "$dev"
> +			return 0
> +		fi
> +		sleep 0.1
> +	done
> +
> +	return 1
> +}
> +
> +setup_devs()
> +{
> +	cleanup_devs
> +
> +	add_dummy "$DUMMY_A" || return 1
> +	add_dummy "$DUMMY_B" || return 1
> +
> +	add_rxe "$RXE_A" "$DUMMY_A" || return 1
> +	add_rxe "$RXE_B" "$DUMMY_B" || return 1
> +}
> +
> +cleanup_devs()
> +{
> +	ip link del "$DUMMY_A" 2>/dev/null
> +	ip link del "$DUMMY_B" 2>/dev/null
> +}
> +
> +setup()
> +{
> +	OLD_MODE=$(rdma system show 2>/dev/null |
> +		   sed -n 's/.*netns \([^ ]*\).*/\1/p')
> +	[ -n "$OLD_MODE" ] || ksft_skip "failed to read RDMA netns mode"
> +
> +	rdma system set netns exclusive >/dev/null 2>&1 ||
> +		ksft_skip "rdma netns exclusive mode is not supported"
> +	MODE_CHANGED=1
> +
> +	ip netns add "$NS1" || return 1
> +	ip netns add "$NS2" || return 1
> +}
> +
> +cleanup()
> +{
> +	cleanup_devs
> +
> +	ip netns del "$NS1" 2>/dev/null
> +	ip netns del "$NS2" 2>/dev/null
> +
> +	if [ "$MODE_CHANGED" -eq 1 ]; then
> +		rdma system set netns "$OLD_MODE" 2>/dev/null
> +	fi
> +
> +	for m in "${MODS[@]}"; do
> +		modprobe -r "$m" 2>/dev/null
> +	done
> +}
> +
> +rdma_supports_combined_move_rename()
> +{
> +	rdma dev help 2>&1 | grep -Eq 'netns .*name|name .*netns'
> +}
> +
> +[ "$(id -u)" -eq 0 ] || ksft_skip "must be run as root"
> +need_cmd ip
> +need_cmd rdma
> +need_cmd modprobe
> +
> +trap cleanup EXIT
> +
> +for m in "${MODS[@]}"; do
> +	modinfo "$m" >/dev/null 2>&1 || ksft_skip "module $m not found"
> +	modprobe "$m" || fail "failed to load $m"
> +done
> +
> +setup || fail "failed to create net namespaces"
> +
> +ktap_print_header
> +ktap_set_plan 7
> +
> +if setup_devs &&
> +   rdma dev set "$RXE_A" netns "$NS1" &&
> +   rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" &&
> +   rdma dev set "$RXE_B" netns "$NS2" &&
> +   rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" &&
> +   rdma_dev_exists "$NS1" "$RXE_SAME" &&
> +   rdma_dev_exists "$NS2" "$RXE_SAME"; then
> +	ktap_test_pass "$TEST_SAME_NAMES"
> +else
> +	ktap_test_fail "$TEST_SAME_NAMES"
> +fi
> +cleanup_devs
> +
> +if ! setup_devs ||
> +   ! rdma dev set "$RXE_A" netns "$NS1" ||
> +   ! rdma_ns "$NS1" dev set "$RXE_A" name "$RXE_SAME" ||
> +   ! rdma dev set "$RXE_B" netns "$NS2" ||
> +   ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME"; then
> +	ktap_test_fail "$TEST_MOVE_CONFLICT"
> +elif rdma_ns "$NS1" dev set "$RXE_SAME" netns "$NS2" >/dev/null 2>&1; then
> +	ktap_test_fail "$TEST_MOVE_CONFLICT"
> +elif rdma_dev_exists "$NS1" "$RXE_SAME" &&
> +     rdma_dev_exists "$NS2" "$RXE_SAME"; then
> +	ktap_test_pass "$TEST_MOVE_CONFLICT"
> +else
> +	ktap_test_fail "$TEST_MOVE_CONFLICT"
> +fi
> +cleanup_devs
> +
> +if ! setup_devs; then
> +	ktap_test_fail "$TEST_MOVE_RENAME"
> +elif rdma dev set "$RXE_A" netns "$NS2" &&
> +     rdma_ns "$NS2" dev set "$RXE_A" name "$RXE_NEW"; then
> +	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
> +	   ! rdma_dev_exists "" "$RXE_A"; then
> +		ktap_test_pass "$TEST_MOVE_RENAME"
> +	else
> +		ktap_test_fail "$TEST_MOVE_RENAME"
> +	fi
> +else
> +	ktap_test_fail "$TEST_MOVE_RENAME"
> +fi
> +cleanup_devs
> +
> +if ! rdma_supports_combined_move_rename; then
> +	ktap_test_skip "$TEST_COMBINED_MOVE_RENAME"
> +elif ! setup_devs; then
> +	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
> +elif rdma dev set "$RXE_A" netns "$NS2" name "$RXE_NEW"; then
> +	if rdma_dev_exists "$NS2" "$RXE_NEW" &&
> +	   ! rdma_dev_exists "" "$RXE_A"; then
> +		ktap_test_pass "$TEST_COMBINED_MOVE_RENAME"
> +	else
> +		ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
> +	fi
> +else
> +	ktap_test_fail "$TEST_COMBINED_MOVE_RENAME"
> +fi
> +cleanup_devs
> +
> +if ! setup_devs; then
> +	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
> +elif rdma dev set "$RXE_A" name "$RXE_SAME" &&
> +     rdma dev set "$RXE_B" name "$RXE_NEW"; then
> +	if rdma dev set "$RXE_A" name "$RXE_NEW" >/dev/null 2>&1; then
> +		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
> +	elif rdma_dev_exists "" "$RXE_SAME" &&
> +	     rdma_dev_exists "" "$RXE_NEW"; then
> +		ktap_test_pass "$TEST_SAME_NETNS_DUP_RENAME"
> +	else
> +		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
> +	fi
> +else
> +	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
> +fi
> +cleanup_devs
> +
> +if ! setup_devs; then
> +	ktap_test_fail "$TEST_TEARDOWN_RETURN"
> +elif ! rdma dev set "$RXE_A" name "$RXE_SAME" ||
> +     ! rdma dev set "$RXE_B" netns "$NS2" ||
> +     ! rdma_ns "$NS2" dev set "$RXE_B" name "$RXE_SAME" ||
> +     ! rdma_dev_exists "$NS2" "$RXE_SAME"; then
> +	ktap_test_fail "$TEST_TEARDOWN_RETURN"
> +else
> +	ip netns del "$NS2"
> +	returned=$(wait_rdma_dev_on_netdev "$DUMMY_B")
> +	ktap_print_msg "device returned to init_net as '${returned:-<missing>}'"
> +	if rdma_dev_exists "" "$RXE_SAME" &&
> +	   [ -n "$returned" ] &&
> +	   [ "$returned" != "$RXE_SAME" ] &&
> +	   [ "${returned#ibdev}" != "$returned" ]; then
> +		ktap_test_pass "$TEST_TEARDOWN_RETURN"
> +	else
> +		ktap_test_fail "$TEST_TEARDOWN_RETURN"
> +	fi
> +fi
> +cleanup_devs
> +
> +ktap_finished

-- 
Best Regards,
Yanjun.Zhu


