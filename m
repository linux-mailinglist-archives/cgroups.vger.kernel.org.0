Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922EC5962B9
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiHPSwm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiHPSwk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 14:52:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5985FB9
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 11:52:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso5840358wmb.2
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=5gMKQRpWDdjEmS+r2aL9i2O5+nVG9o/r7VVu0SGzm1M=;
        b=gRI3uuMxxiAxi1hxTP+k3wTpq6aRMob4XanAQsZSMxCBW8hjOB310VMxwDyi36XNUA
         /k7GTPEX7uNTk/rDZ4f2KbkmYjQsRUs7VgXfBLup/aINuc1kzpIU9k0BJpqH32w7vl+r
         T2L7DF2hQg9FZCGAbMp6TfQJDrYQDIEfJQt2sTi0Z7UaXcdYkL8Dki1uhSwQHAKbZv7A
         Aardr6gRqS/qsJ0mtbnQ1GiJkqDnKX+AvA9BQnbCbUHoYh1/XzDLo2aW1KWMwzHsfJEB
         6fTPOTgiexyswIer7EQCw9r8M371D1n87lkeZq2ZumKVLvE3O7kXlxdCWdnQ6dyAqTU6
         0hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5gMKQRpWDdjEmS+r2aL9i2O5+nVG9o/r7VVu0SGzm1M=;
        b=BEmL7cYn8biNWafUQr4wpXZF7hCUcaxONSgW7L9VocumHaRQUXzR3FqGcLicY/c0P7
         g7wfXLK7ZDVSLd6gJJihUitReRau1RwcfAKhBJLnaCGII5eZdqVhosG9/bmLoHkdOw+u
         fsEHmNy7u62mnbRYQFZuBDAysuzEZ9iQUAkhwqdgIW+K1WEXTSDyJFXhWzJ+C5oN9m7n
         gJVg+ERnu0Nqlh9VMDPUVCnnxanBUIlILQNw2R4N7+dU7Tnkn1aWm/7YMy4eSP5FlKyH
         HFnT1AiIRIEKGPTmdwbasn+zkPBAvu8zHhT8zhmVClZzivkqVKvfL3ii+YZtIBE7eQd8
         GBQA==
X-Gm-Message-State: ACgBeo3iDMoedQpbVD73z3IuDFUBnL4zovpLt7CXigR0iySjmc4H1dEA
        UPwNLsFetTOtvXLpbeRBLHGHGMnxXDMHWn5znWlf5EwboKs=
X-Google-Smtp-Source: AA6agR5xNKi4FmrppeFqtsxpoHzeW3N8ZVvwL6pnHhTmIoOF8hO2B/jYGQHCllmzmuKXRvy3BsbsBLmB94y3Sp4Ugbw=
X-Received: by 2002:a05:600c:3502:b0:3a6:edc:39f8 with SMTP id
 h2-20020a05600c350200b003a60edc39f8mr1056368wmq.200.1660675958030; Tue, 16
 Aug 2022 11:52:38 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>
Date:   Tue, 16 Aug 2022 21:52:26 +0300
Message-ID: <CANOLnON11vzvVdyJfW+QJ36siWR4-s=HJ2aRKpRy7CP=aRPoSw@mail.gmail.com>
Subject: UDP rx packet loss in a cgroup with a memory limit
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I'm unsure if it's supposed to be like this, but I'm seeing this on
various hardware combinations/VMs and Debian kernel versions, plus
self-compiled vanilla 5.19.1 I just tried. It looks like this only
happens on cgroup v2:

Debian11/bullseye (cgroup v2), distro kernel: yes
Debian11/bullseye (cgroup v2), vanilla 5.19.1: yes
Debian10/buster (cgroup v1), bpo kernel: no
Debian10/buster (cgroup v2)*, bpo kernel: yes
* - booted with 'systemd.unified_cgroup_hierarchy=3D1' to enable cgroup v2

Basically, when there is git activity in the container with a memory
limit, other processes in the same container start to suffer (very)
occasional network issues (mostly DNS lookup failures). Git's or other
processes' memory usage doesn't seem to be anywhere close to the
limit. The fact about packet drops can be seen from /proc/net/snmp
"Udp InErrors" counter increasing, as well as "drops" counter
increasing in /proc/net/udp . Some other random details about this:
- stopping git (its disk activity?) makes the packet loss stop
- tcpdump (ran in the container itself) shows packet correctly
arriving without errors, but the process times out waiting for
response
- if memory limit is removed the problem disappears
- if memory limit is set to host's RAM size, the problem disappears
- reducing dirty_ratio, dirty_background_ratio doesn't help

My recipe to reproduce:
- install kubernetes on a host machine with Debian11 and 32GB RAM
- create a debian9 container with 'resources: limits: memory: "8G"'
- in the container:

# run this:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
cd linux
while git checkout linux-2.6.32.y && git checkout linux-5.19.y; do true; do=
ne
# at the same time in the same container:
while sleep .1; do host <remotehost>. > /dev/null; awk '/^Udp:
[0-9]/{print $4}' /proc/net/snmp; done

The packet drop counter should start increasing after some time. The
effect is much stronger if the git repository is bigger and has
different multi-gigabyte files in those branches. Can something be
done to avoid this packet loss?

Gra=C5=BEvydas
