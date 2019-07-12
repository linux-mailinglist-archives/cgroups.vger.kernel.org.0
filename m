Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2428F67226
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2019 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfGLPPf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jul 2019 11:15:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36741 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfGLPPc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jul 2019 11:15:32 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so21118137iom.3
        for <cgroups@vger.kernel.org>; Fri, 12 Jul 2019 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2opEnBuVBF2b4E5QanZT3B1PxQTl1jpFqVeaeD4Jvac=;
        b=BMS+LBZ1HOJ+oPmT+jj9cCB2CMuhLD9hOgL1EGxhXgjcCFU+uRhdlTEHJctcvcAfAC
         93xCyhVww0XoYzbRJRJbpZBsYO3Bm1q/MlPGVvrNSmWS6qfkXQz8BXXUjRJsSG2wkg1B
         oUhykgoEyU+U5WMY8pngtLd8pQv2pIfwtfSV3MVO+kJRkbbD+jxi3cwlmNKFU6maqscI
         iIz0r5umTAoC5x9daY2n1PVhdWCYjSYP5JjtzczVfPEaIuMScEe303uYSFPRxEjPxbTY
         wo2uvzLdn+ynMMpp8KKHkC8MInm7bHAk0Gz2dmFjF6xGUKzzWIe57apPN0x9lMRWIqqQ
         wFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2opEnBuVBF2b4E5QanZT3B1PxQTl1jpFqVeaeD4Jvac=;
        b=kL12bBB7W3qsjSjCJCXXZYgsd4xO5NyQ4qUg9Y+MD1JNjGOp45S0+xuUbS4XBg84ey
         ttN/P61XMucQy84KFhxGPhOWybhuPYhSHOejU1jOA6gawe+40YX1wWzj61FuPjX6NNNX
         zqstFAa+aOYiSTK7Tq5UCXBgX5nZQlZ5xEjoHQYcLFv8/j0nCfED0YDx/C2E0+CKjfgj
         pDA2kjHaOISv6kfKT5N+0DFZeKNWPqhDvlc3WJBPN6qZDstKD15KJmXilPnhbScjvZn2
         CSvSDLkjqpU1rBXDG3Hs6MsMCTqEjro9gdw/rRJPZHl4EWikbCDqTFscQxL/IvESy+F/
         zcTw==
X-Gm-Message-State: APjAAAW6j8ehL/+5zwB962oQEhUBuEOhdenpkVvedNTfenV1NCp0makj
        bfOTl+8Ihdo1W5DToeAy5Owy/nTxvz0=
X-Google-Smtp-Source: APXvYqxNzK45erpGagcbIG8GrfCOqm46U/1e0qdgZFVftYMWqnRGnTZfkMPl7UYDH4Wj4yMq6IdAPw==
X-Received: by 2002:a02:b812:: with SMTP id o18mr1716469jam.64.1562944530468;
        Fri, 12 Jul 2019 08:15:30 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e22sm6692139iob.66.2019.07.12.08.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:15:29 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: add entry for block io cgroup
To:     Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <156284038698.3851.6531328622774377848.stgit@buzz>
 <20190712142502.GA680549@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82bc7337-c48f-7559-bd9b-6a21ccbfceb0@kernel.dk>
Date:   Fri, 12 Jul 2019 09:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712142502.GA680549@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/12/19 8:25 AM, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Thu, Jul 11, 2019 at 01:19:47PM +0300, Konstantin Khlebnikov wrote:
>> +CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
>> +L:	cgroups@vger.kernel.org
>> +F:	Documentation/cgroup-v1/blkio-controller.rst
>> +F:	block/blk-cgroup.c
>> +F:	include/linux/blk-cgroup.h
>> +F:	block/blk-throttle.c
>> +F:	block/blk-iolatency.c
>> +F:	block/bfq-cgroup.c
> 
> Given that blkcg changes are often entangled with generic block
> changes and best routed through block tree, I think it'd be useful to
> add the followings.
> 
> M:      Tejun Heo <tj@kernel.org>
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org
> T:      git git://git.kernel.dk/linux-block

I applied the patch with these additions.

-- 
Jens Axboe

