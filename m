Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0D1947D9
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCZTs6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 15:48:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33202 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTs6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 15:48:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id c14so6608769qtp.0;
        Thu, 26 Mar 2020 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+X43fOowivo9wQhliFx6lnhtIaMEbCHpeVUMSBZZuGY=;
        b=U5JDgEKNA0GkBeHvV5CHdgdArh42FYVrmzkogGBIyPh3UbwY/HtRPl1L7OI8kSvTuM
         t7BJG7ezUxnmgRFbliiaIwK8OBPkiXIeGrhetTsK6rDsWt1lNTKwuMPWLqOYF0Uz07uP
         vlAyx6tjVavmsfFsclBaBM5kI1FLo9fg+4Ct2XX22fBdqTWnySs24i1kyUSGY1vHhgPy
         CuU82/h7zfoXRaJJcIxxSNIjvjQrS8IIf64WfaRfpBpfzEocyTurwPs9dmGXh/+Q/esb
         pdpiaqT4PIpE6gDZyhqhdIScxy7PlNi43u4b6oe1NowK41XpBBOw6RXKLF4zN+sjinb5
         JVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+X43fOowivo9wQhliFx6lnhtIaMEbCHpeVUMSBZZuGY=;
        b=gpHMmgwjXTLKJQifPSzZLLaN3v+PGWZSCJ80XSVyvmKCPJra3h5OQ0fDUV0ImaYnn3
         2Gq3WCxKiveUTZDKIjK2KsQ3FlF5yq1usYD7kYFkbeYgMETG5Zxp6eiIVnXml6ix55sv
         2+Tp4LEwQbwoiqnKbsAB296CkuLZgwgiKHYbVOnESrp4AeyvnpxVqwRmSllZHRtEWuG8
         Ro7d78oOf4gMWrjKF7FzVCtZCUg2HiewgV0euuneNznaoKn2C39u/cbwmOvb/rVA+fae
         B2STsO+8kGrfNUNhLh5ZtRXZ1F+p0lTSdU62ADb0VFxNvmNLkB83swA+dM8IKP29neQd
         GrYQ==
X-Gm-Message-State: ANhLgQ3Z5kYKtiCZEuINIodqUmW7P96jddmWcW9U+bCjSuSGXxYW+SWK
        KOaDYfLnkWcMLhlwBG7SIP5RPpTl2yM=
X-Google-Smtp-Source: ADFU+vtLFlzARKEMRWc1YGd7T4n7YiyfdU1NRA6ydWosFisgJpC626glGMvBSi56eVhlehZTCUKjjA==
X-Received: by 2002:ac8:366d:: with SMTP id n42mr10293278qtb.180.1585252137334;
        Thu, 26 Mar 2020 12:48:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d3b8])
        by smtp.gmail.com with ESMTPSA id 10sm1707115qtt.54.2020.03.26.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:48:56 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:48:55 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        jsbarnes@google.com, sonnyrao@google.com, vpillai@digitalocean.com,
        peterz@infradead.org, Guenter Roeck <groeck@chromium.org>,
        Waiman Long <longman@redhat.com>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200326194855.GP162390@mtj.duckdns.org>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326194448.GA133524@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 03:44:48PM -0400, Joel Fernandes wrote:
> It is not really that big a change. Please go over the patch, we are not
> changing anything with how ->cpus_allowed works and interacts with the rest
> of the system and the scheduler. We have just introduced a new mask to keep
> track of which CPUs were requested without them being affected by hotplug. On
> CPU onlining, we restore the state of ->cpus_allowed as not be affected by
> hotplug.

It's not the code. It's the behavior. I'm not flipping the behavior for
the existing cgroup1 users underneath them at this point. As-is, it's a
hard nack. If you really really really want it, put it behind a mount
option.

-- 
tejun
