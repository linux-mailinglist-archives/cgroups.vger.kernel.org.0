Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30374C90F0
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiCAQyX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 11:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiCAQyS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 11:54:18 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1058A4CD50
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 08:53:37 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id f11so498430qvz.4
        for <cgroups@vger.kernel.org>; Tue, 01 Mar 2022 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NBf4zMMtjHDXxe1QGY4+VAhDQU0P1h16it+M1Z5ezfk=;
        b=JlsDWggs0x19ThNsAcnAVPOtWKVoCdk27Gb/UtoTg5zblhrKphPa6ffd7zsHRqZdW9
         WeTSHEoX+wjpaAMYfetDfCwhDuBKy/xZc7004bh3Rfj5JA+tFuC0DkqxXasX+DC7VhUw
         78D71MUvqHc0ByixFnc8lAIHomB1zt0avWk3qw3fNik0nkORny6KgGP2qfxa/pQj317B
         hRy1+w6M9mx/vJwiHTuHWR70vS2izBh4TljfNt4WsiziktHJBW9ew8YPcKRqLDPBq2dE
         vKLXPDJ/+nrLU8EEX+Gp8oZGuza3Cs4YsFP7hiUdgPO+xX38LQXHyM6asHW6gZEMSVTz
         vy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBf4zMMtjHDXxe1QGY4+VAhDQU0P1h16it+M1Z5ezfk=;
        b=h6dJC9AG9s7ho8UpO48zq9ZXRKXlcr26j04MTOAfeuMC/OhjsjuCPoeyaxPgvghvVP
         a1oC3fjDxnzj0yybnFrbD+iYkkUK4gelg1kJVJZ98Bsusw2W97s+K/h9UCXeGITaw9t+
         nbki7qsRpyrGAuAAquhwe4Z9HoTibVjwMxduPSdGI46d1MnCFs9r/6AlmKLBWd6EC22F
         aVAEIn2tTLZRGOpJ7s0wx7plQEPYe2CGT0NRIVnVvNda3cx07OhkhT05+YW9ULK88dB0
         qdR6/6j2rDg7dEpYJ0RY7wmwNhr9LaE5u9F4kY6Ncuzk1lIq4lytBWkKzPqW6V9Sjb6h
         j6lQ==
X-Gm-Message-State: AOAM5329rLkUAeOkaip5LpLJa2ozo36eDkclV2fdTSuYPVkSqheN18Ry
        gcdYHj2Spa1766UUKB2h00r6Jw==
X-Google-Smtp-Source: ABdhPJzHRf0LvkGWBrv5Hhm6Gbz8yOoLBMQobQeNYsJRbaQXOLWsvgHhj2La7A8fgYIZXh+G6XKQ8A==
X-Received: by 2002:a0c:f6cc:0:b0:432:beeb:fd11 with SMTP id d12-20020a0cf6cc000000b00432beebfd11mr14898457qvo.49.1646153616186;
        Tue, 01 Mar 2022 08:53:36 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a181600b002dd4f62308dsm9247965qtc.57.2022.03.01.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:53:35 -0800 (PST)
Date:   Tue, 1 Mar 2022 11:53:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Anita Zhang <the.anitazha@gmail.com>
Subject: Re: Explanation for difference between memcg swap accounting and
 smaps_rollup
Message-ID: <Yh5Pj5Z6pXbUyfio@cmpxchg.org>
References: <12f7d0bef9340035b82a007cc37bd09c48d86c3f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f7d0bef9340035b82a007cc37bd09c48d86c3f.camel@sipsolutions.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Benjamin,

On Fri, Feb 25, 2022 at 05:10:05PM +0100, Benjamin Berg wrote:
> Hi,
> 
> I am seeing memory.swap.current usages for the gnome-shell cgroup that
> seem high if I compare them to smaps_rollup for the contained
> processes. As I don't have an explanation, I thought I would ask here
> (shared memory?).
> 
> What I am seeing is (see below, after a tail /dev/zero):
> 
> memory.swap.current:
>   686MiB
> "Swap" lines from /proc/$pid/smaps_rollup added up:
>   435MiB
> 
> We should be moving launched applications out of the shell cgroup
> before doing execve(), so I think we can rule out that as a possible
> explanation.
>
> I am mostly curious as we currently do swap based kills using systemd-
> oomd. So if swap accounting for GNOME Shell is high, then it makes it a
> more likely target unfortunately.

Shared memory is one option. For example, when you access tmpfs files
with open() read() write() close() instead of mmap().

Another option is swapcache. When swap space is plentiful, the kernel
makes it hold on to copies of pages even after they've been swapped
back in. This way, the next time they need to get "swapped out", it
doesn't require any IO, it can just drop the in-memory copy. From an
smaps POV, swapped in pages are Rss, not Swap. But their swap copies
still contribute to memory.swap.current, hence the discrepancy.

In terms of OOM killing, the kernel will stop keeping swap copies
around when more than half of swap space is used. That should give
plenty of headroom toward the OOM killing thresholds.

If you want to poke around on your machine, here is a drgn script that
tallies up the cache-only swap entries:

---
#!/usr/bin/drgn

MAX_SWAPFILES=25
SWAP_HAS_CACHE=0x40

swapcache=0
for i in range(MAX_SWAPFILES):
    si = prog['swap_info'][i]
    if si:
        for offset in range(si.max.value_()):
            if si.swap_map[offset].value_() == SWAP_HAS_CACHE:
                swapcache += 1
print("Cache-only swap space: %.2fM" % (swapcache * 4 / 1024.0))
