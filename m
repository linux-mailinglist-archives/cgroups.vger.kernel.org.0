Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE788164991
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBSQM0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 11:12:26 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:45776 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSQM0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 11:12:26 -0500
Received: by mail-qv1-f53.google.com with SMTP id l14so407396qvu.12;
        Wed, 19 Feb 2020 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vu5V5rWZHyaueFfLFkEzCLEhOtHzeZSUWOLy/RNDYxo=;
        b=fWD0BpDlqjIvBRJjxFbuwfxPTi9xvRf58lXoOBdijX4wsvutNd7gBZtp/BuDfPcGfg
         QRY3Kyh5b7R0i/9gzorKY6Lh5L1wJTmDQY/3u4KIybAc206Ujo1rKsoUZgWlqEjLTbwg
         5qMIAz9gG7ke+PkPchTBy/Xx4F/OWSz7dviJnzyczN1sHo6xWJmPEHkl/z3qehySpQT6
         2YFQgdXnPD57KPnU3Pz1f3qZgTT9+6afevkoDpKxZW850MzDMZBsET9mvMKmYLtthANn
         wVQEUWUrronURe4HGk3bIHkZq5r0xkPuxwffXu1TAdxc8DfbDzMxzQ1icJi+MttU+cxJ
         EalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Vu5V5rWZHyaueFfLFkEzCLEhOtHzeZSUWOLy/RNDYxo=;
        b=Kb+KvvagBU4wzCeoD9XotEiE6sDflaS4v2uuvgyMEtWPzYRlumeoJrYf/cH0dkMZNl
         CieAqjR3ykgn2NXoySAPxsRsW2moNX/zuaseQwfVZjKu0U7d+SB62Y12yRtq1+1eFOjk
         2jEp/ryplI8j6esdiJUhK3slvrKtpGEGRJBYYyyxuYN2N2RNdnNHdjVZ8NUUlHqHbBR2
         iURbkd75dhqauaVhMCjCnuwxvtFdrafq1/jmDVA54Pjd+utR/FByXlnnMbSIf/TzoqWq
         GkAQVoXwcv2lixi1e5kH79HSrG5TNDFV/3fhWES8FUrwU5BrHHI/PHVLIxt1TMRbtDk5
         oGWQ==
X-Gm-Message-State: APjAAAUkHSNrihKIRsBeIGA+e293rP9xgaOKnweMTKl6pU9lwpoMuw3Q
        4ewNQmlNk6Ry6sm34K1tLkIRCE398Ro=
X-Google-Smtp-Source: APXvYqzK2N1iOHIKrA82Tl49sCBgNLUSLZlY1PZ0D5JQz2oMqybSMjtAITpUNCchUQbFTaanxsR3uw==
X-Received: by 2002:a0c:a998:: with SMTP id a24mr22155326qvb.11.1582128743419;
        Wed, 19 Feb 2020 08:12:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:e7ce])
        by smtp.gmail.com with ESMTPSA id c21sm34629qkj.130.2020.02.19.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:12:22 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:12:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
Message-ID: <20200219161222.GF698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
 <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com>
 <20200219151922.GB698990@mtj.thefacebook.com>
 <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com>
 <20200219154740.GD698990@mtj.thefacebook.com>
 <59426509.702.1582127435733.JavaMail.zimbra@efficios.com>
 <20200219155202.GE698990@mtj.thefacebook.com>
 <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 11:08:39AM -0500, Mathieu Desnoyers wrote:
> I wonder if applying the online cpu masks to the per-thread affinity mask
> is the correct approach ? I suspect what we may be looking for here is to keep

Oh, the whole thing is wrong.

> the affinity mask independent of cpu hotplug, and look-up both the per-thread
> affinity mask and the online cpu mask whenever the scheduler needs to perform
> "is_cpu_allowed()" to check task placement.

Yes, that's what it should have done from the get-go. The way it's
implemented now, maybe we can avoid some specific cases like cpuset
not being used at all but it'll constantly get in the way if you're
expecting thread affinity to retain its value across offlines.

-- 
tejun
