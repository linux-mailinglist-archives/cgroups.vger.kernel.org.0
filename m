Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF93EE515
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 17:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfKDQtK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 11:49:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41634 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDQtK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 11:49:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so18224326qkd.8;
        Mon, 04 Nov 2019 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tolm0KjoKvfRTvG4VjDhlcLgC6/zdCu4XmFbBPjTkwY=;
        b=QDb28cZajsvYgqeWWWhRnDIReogocXA/kxJfrHS6albWdfSNMVrp+8MS/zWWV5k5+T
         rNv853PHTXdFaUyuxjCXFUyIRcT4ZvKLScrh0pCo04OU5kBwlAITLvKP0d1iTcxYJE5a
         qYIUCczhmyFKKcc2Sf3hIhNvHcN0fcrf7e+f3ZLWrccNxGJN7imun8WvZrw6VF+9OWBX
         41opJ+xmjK2J1Nu+/iVZoCce5+jor1RKkjrOQ/bez2sFnLjFRPr9yM9pLYWx2bjPNNBz
         +3lzIOElaS/CRtT7q/u4sXn9CX/MB357yZYyb1r718eM6SUk+k9Wr/oaYgKxq7kY+svp
         Wrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tolm0KjoKvfRTvG4VjDhlcLgC6/zdCu4XmFbBPjTkwY=;
        b=abp8Q0j4mmeuQNNW1JlGoBGx2fwZeuLi/P1+v97PervuC7HFA3sTHfLBENYha18TUs
         8ATW3kIb/xwkay0jwsYAtbNfdIDMlBokhXBVO+BJoZCYMwEbiIDQjwTBfpiVczb/8H/3
         15lBfcMbGIRsCk1rSFyOoduVelyocnLAAuHXu1kxD+nuHO8mGGcl8rzxa3Ijh83v6ikX
         /eG8x5gn2V693VRQxgMnPx1CFEbFI9OF9pk6ivsBIGJ5of+6V33bAawIWiLFfPa/FkRr
         xquDLNTQrST7L64UPIaP4Qbv0V6QYXsjb6VOlyiaFEuIoJQeYdJaQa3yPNmXMQ0sDb0D
         vJSA==
X-Gm-Message-State: APjAAAVmLRgEoOVxhkU2we9QgLkjXZ2eXRRdeIwJ59EO4bGqyK3PbYKu
        0Z23aH7ObQGZjXgMnQtnUP4=
X-Google-Smtp-Source: APXvYqw4k9V3X/BYQ3OocJr+kPDbvPDB7i3FPeL5D/TOiY0T67m3Q5y4DCjF9Sg77/M3iEa91YcomQ==
X-Received: by 2002:a37:4cd5:: with SMTP id z204mr9625854qka.153.1572886147428;
        Mon, 04 Nov 2019 08:49:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id d189sm8514447qkf.67.2019.11.04.08.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 08:49:06 -0800 (PST)
Date:   Mon, 4 Nov 2019 08:49:03 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cgroup: Sync cgroup id and inode number
Message-ID: <20191104164903.GQ3622521@devbig004.ftw2.facebook.com>
References: <20191104084520.398584-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104084520.398584-1-namhyung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 04, 2019 at 05:45:18PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This patchset changes cgroup inode number and id management to be in
> sync with kernfs.  The cgroup inode number is managed by kernfs but
> cgroup id is allocated by a separate idr.  The idea is to have a
> single id for internal usage, inode number and file handle which can
> be accessed from userspace.  Actually this work is from Tejun who also
> provided the idea.  I just took over the work and fixed some errors
> and finally was able to run perf for testing.
> 
> The background of this work is that I want to add cgroup sampling
> feature in the perf event subsystem.  As Tejun mentioned that using
> cgroup id is not enough and it'd better using file handle instead.
> But getting file handle in perf NMI handler is not possible so I want
> to get the info from a cgroup node.
> 
> The first patch converted kernfs id into a single 64bit number and in
> the second patch cgroup uses the kernfs id as cgroup id.
> 
> The patches are based on the for-next branch in Tejun's cgroup tree.
> Tested with tools/testing/selftests/cgroup/test_stress.sh.

Sorry about the delay.  I'm still working on the patch series and the
draft patches currently posted aren't quite correct (e.g. netprio is
now trying to allocate arrays which use u64 values as index and that
u64 value can start with 33rd bit set from the get-go).

So, please hold on w/ this series for now.

Thanks.

-- 
tejun
