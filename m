Return-Path: <cgroups+bounces-17657-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spv9IKqFUWoSFwMAu9opvQ
	(envelope-from <cgroups+bounces-17657-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 01:52:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C9673FC7D
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 01:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=dt1rK+bK;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17657-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17657-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8B53024971
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CF40802C;
	Fri, 10 Jul 2026 23:51:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87340861C
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 23:51:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727518; cv=none; b=eR2ColoGdAD6nIOiv/kRM3oaKljDz+5sKAjs1pspENRWJKNa7GUdeB854+OrBixLuSl77DY8jo/ab2R9inwv6QEq6f3SxumPlq1X/3/5FB6TnVWd8eefMeSaEDlu4zpTXS6p24/YNucBV/rpFRlmDhNJHtYf1iHDKZQF/L/cyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727518; c=relaxed/simple;
	bh=O8gtSvZgFfroeKrN4VzmfikT47vC3UulLVIYKCoyNms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWpNZCKicaf8HwqObKITha/kteEWIgT0TYN4wE9Ah6bGI9khDpH15RcknjUXqh3sINpRwR2uLrJoMMa8hKUIHBuc1n29xhyKCYxiYOGhmIwUK7zfws2itUXWMRZ6wP3uPdaDwvP9fBa36VEwF5ulArEsJuAvfS9P2+CQgHoqNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dt1rK+bK; arc=none smtp.client-ip=91.218.175.180
Message-ID: <2aec2d14-0000-4595-aa2a-73aa5ae41060@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783727511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHN3OZqyVBMoc0WzZkstTYo8wC+PciAiKk3q7cpBgqQ=;
	b=dt1rK+bKIACqT4/0ZiipMUIoxmxuUd1chKCHxd8vIYdox4XZZItHIKR37lNh5ZRLIOnT8A
	GLjCt+C/uUBz9lF17uqDQ3SVbBTxVKXJcNKhQCUTN1E8CN09L3yhrXu2MVjhzdgpQwWNCh
	rea8WfnVbxjS6Z/+PNBZYepkzCMc8io=
Date: Fri, 10 Jul 2026 16:51:45 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names test
To: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, jgg@ziepe.ca,
 leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, cmeiohas@nvidia.com,
 roman.gushchin@linux.dev, bvanassche@acm.org, zyjzyj2000@gmail.com,
 shuah@kernel.org, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-14-jiri@resnulli.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260709095532.855647-14-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17657-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0C9673FC7D

On 7/9/26 2:55 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a kselftest script that exercises per-netns RDMA device naming
> with RXE. Cover duplicate names across namespaces, move conflict
> handling, move-with-rename, and same-namespace rename requests.

# timeout set to 45
# selftests: rdma: rxe_netns_names.sh
# TAP version 13
# 1..6
# ok 1 same RDMA device name can exist in two net namespaces
# ok 2 move without rename fails on destination name conflict
# ok 3 move then rename succeeds
# ok 4 move with requested destination name succeeds # SKIP     < --- 
This testcase skip

# ok 5 same-netns rename rejects duplicate name
# # device returned to init_net as 'ibdev35'
# ok 6 netns delete returns device to init_net and renames on conflict
# # 1 skipped test(s) detected.  Consider enabling relevant config 
options to improve coverage.
# # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0
ok 6 selftests: rdma: rxe_netns_names.sh

The above are my test results. But one testcase is skipped.

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


