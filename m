Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60817A8BA
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCEPUZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 10:20:25 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:44373 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEPUY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 10:20:24 -0500
Received: by mail-qt1-f178.google.com with SMTP id h16so4372264qtr.11
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0admXbkeoND1jB4YkR5jDFX42s3DFHa7Q+/Pf5rMHxg=;
        b=dJ2qpBCFGhzqmF9KAojSaaJXA6caHwbTwtepgtX4hoRV3GshwPgGWkjF/pjEhhksLo
         77swNzS8tc5Or1BssMWTMsI/RfvLXMFg8An8cc9XNlvfIoCNVPoUhqEfRSKSDeYcn7zG
         dbjo4MOTwYXYsMXylSk2vrqTN4aJpDjJQpZoOUR/Js5M51yfgtuls1UNPcAYLEfXqcjS
         ncpR6ia/zTgUEaSrW3Vk1flwXJyuOfPnILYfgTWVRMcEkzzvPGbTvU+u0fI2P3+H8eIe
         t4i/LDSO/n6h/hhDa8r+i3t4hoRuwh6pWqGhq+4mtzdQBSMnLMv0U9QXpl2Ssi0fERuF
         lvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0admXbkeoND1jB4YkR5jDFX42s3DFHa7Q+/Pf5rMHxg=;
        b=ZMhVIcBy+aY+Eapzpwmyo4WadMvUG+1sQtoNj5kC3LVrY4sCgWtW6GQR6PGo/p4UW2
         pTw2dcCKL+nFicDI9HRkbaEfwtAPO6Z9BN8Y7KWDoA1jIfLun9J0ekNKov0Yy7HZcW7G
         xbcgB7LrRR0NZIgj/hyUFENYXB2gx7tQUhzvkv31gbCL/UwvjGcsuCiRXqRa/8Cki/Cz
         TM95aGvKYqDxnSLwkMjLkcFbIuwDD2flrPPwfe5xjulUf7IiVTbl2qTAXxfXDmAXwgcn
         Rqo49gtNuHhs2g7OqgYwhW0ocYrh1gPDcf4njFMMjnc21+3QLzI52kh9ADbsSf/YJXgf
         oa+Q==
X-Gm-Message-State: ANhLgQ2zKE0GCYq5r8kpX1nkEiwK/jpB+yas3+evC6Mrqlt23FGh/qCi
        Zk6IdVpk6N43tcUibnrYqTU=
X-Google-Smtp-Source: ADFU+vvIaffiZDXUvvIjtxhNbcW3R9trE/U3TJ0GFD4O2nLDazcgr/TxDHLGjz9jldUZR8sOabJXYQ==
X-Received: by 2002:aed:3fa3:: with SMTP id s32mr7477922qth.10.1583421623645;
        Thu, 05 Mar 2020 07:20:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e7c7])
        by smtp.gmail.com with ESMTPSA id 69sm886089qki.131.2020.03.05.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:20:22 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:20:21 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org
Subject: Re: [BUG] NULL pointer de-ref when setting io.cost.qos on LUKS
 devices
Message-ID: <20200305152021.GA6939@mtj.thefacebook.com>
References: <1dbdcbb0c8db70a08aac467311a80abcf7779575.camel@sipsolutions.net>
 <20200303141902.GB189690@mtj.thefacebook.com>
 <24bd31cdaa3ea945908bc11cea05d6aae6929240.camel@sipsolutions.net>
 <20200304164205.GH189690@mtj.thefacebook.com>
 <71515f7a143937ab9ab11625485659bb7288f024.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71515f7a143937ab9ab11625485659bb7288f024.camel@sipsolutions.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Mar 05, 2020 at 11:31:29AM +0100, Benjamin Berg wrote:
> > In the longer term, what we wanna do is controlling at physical
> > devices (sda here) and then updating dm so that it can maintain and
> > propagate the ownership correctly but we aren't there yet.
> 
> Perfect, so what I am seeing is really just a small systemd bug. Thansk
> for confirming, I'll submit a patch to fix it.

IO control is a bit confusing right now. Here's the breakdown.

* There are four controllers - io.latency, io.cost, io.max and bfq's
  weight implementation.

* io.latency and io.cost when combined with btrfs can control all IOs
  including metadata IOs and writebacks while avoiding priority
  inversions.

* wbt may interfere with IO control. It can be disabled with "echo 0 >
  /sys/block/DEV/queue/wbt_lat_usec".

* io.latency is useful to protect one thing against everything else
  but it gets tricky when multiple entities competing at different
  priority levels.

* io.cost is what we're verifying against and deploying. While
  system-level configuration is a bit involved
  (/sys/fs/cgroup/io.cost.model and /sys/fs/cgroup/io.cost.qos).
  Actual cgroup configuration is really simple. Simply enabling IO
  controller and leaving all weights at default often can achieve most
  of what's needed.

Thanks.

-- 
tejun
