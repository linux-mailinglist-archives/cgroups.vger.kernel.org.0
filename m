Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88953776C5
	for <lists+cgroups@lfdr.de>; Sun,  9 May 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhEINVT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 May 2021 09:21:19 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:47461
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhEINVS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 May 2021 09:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=tqv4uysrlnm4medenf5ivv2dv3fy2re7; d=pxeger.com; t=1620566414;
        h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Wzf2ZYdzYwPSwxlvvNXWZXEuY6BAfTpoORaP45e2ZO8=;
        b=WecsRAg2WOIBkFJn8/lFyDdQLzghj15Y9ny1kEL2sL5hmmZiu0T8awjD+zryD7lq
        tz/a617fMRvzFf/W/8CAc0F+LlvXznwFrUoNDpdd/IybnWvnqyDqaYpGSCWVhwE1NUi
        PKGz2XePeEsfQ/B7qQPviWaXgSZUigjhhStwFsxo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1620566414;
        h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Wzf2ZYdzYwPSwxlvvNXWZXEuY6BAfTpoORaP45e2ZO8=;
        b=aAwU/hpdYo/Bdl9gE9tJezkoSccn1soOsLqslL765rOxTBk+Z8Mw76E+ZaWurzRN
        IUbCjybGJwnNx5cSAhVB1c6YIEVrtcAswmtJXdzvydOfF5IqrTR/463INKWuKFjXq13
        gVChpR/1lXKOPtVBcvmUT0thXcdiCSah7dphp6xM=
From:   Patrick Reader <_@pxeger.com>
To:     cgroups@vger.kernel.org
Subject: v2 cpu.max question
Message-ID: <0102017951491312-b3c91c35-577a-466c-965b-fa004d314980-000000@eu-west-1.amazonses.com>
Date:   Sun, 9 May 2021 13:20:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Feedback-ID: 1.eu-west-1.O8fLL1RnZ8YOldtp6Bf8+xGGBJTnUb+xpx8eQnH6GAs=:AmazonSES
X-SES-Outgoing: 2021.05.09-54.240.7.19
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

I have a question about cgroup v2's `cpu.max` value. The documentation (https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#cpu-interface-files) says:

> cpu.max
>
>     A read-write two value file which exists on non-root cgroups. The default is “max 100000”.
>
>     The maximum bandwidth limit. It’s in the following format:
>
>     $MAX $PERIOD
>
>     which indicates that the group may consume upto $MAX in each $PERIOD duration. “max” for $MAX indicates no limit. If only one number is written, $MAX is updated.
>
"the group may consume upto $MAX in each $PERIOD duration". But $MAX what? Microseconds? Clock cycles? Arbitrary CPU scheduling units with only a relative meaning? Elephants? At the moment I don't know what values are sensible to set here.

I found the scheduler docs (https://www.kernel.org/doc/html/latest/scheduler/sched-bwc.html#management) which describe what sounds like might be a similar mechanism but for cgroup v1 - is this the same (in which case $MAX would in fact be measured in microseconds)?

Unless I'm missing something, I think the documentation should be updated to include the answer.

Thanks,

Patrick Reader

(I hope this is an appropriate forum to ask in - please direct me elsewhere if necessary).

