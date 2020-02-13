Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0805015C8F6
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgBMQ5P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 11:57:15 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41324 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgBMQ5N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 11:57:13 -0500
Received: by mail-qv1-f66.google.com with SMTP id s7so2916727qvn.8;
        Thu, 13 Feb 2020 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/9pAJl5lwO/l/LEFjlIiSIPtfDfflLg/CjlywKeZ4W0=;
        b=pka2Qi2fbd4HXtA3HE9p7vhJ6JpjDs0dwsLG0U+e+THmClapZAuyNGAXaL5mEj5uQq
         3s/RQwhkHiv6KWwihYhaeNTXKGqk4U374R5+UjJXesDuYKEzBXCMXJCgEpQBMCxPnDCS
         5jowrfBMqUdowxvefJdPm6iqwb/LNFkrv5MZ/fBv4iTL2wrVypqI6oHgm2pS2mqSsPNE
         6UIq7Wkt1Rk9cPW8ee159csvhfNdZMOPWpZM95gXav8SFLtL7tgVPVfpE/Dp1ZoZynqn
         Hj8iF2bqUlyu9r5/ROJxIRGMnT4izUTycemTJT1HXfkqreQteC/5+FWT+wAUz7O43kK6
         ZQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/9pAJl5lwO/l/LEFjlIiSIPtfDfflLg/CjlywKeZ4W0=;
        b=ierNz4pQPFzLoa15vpEjfro2ZumHqNVs5p4XGQTxqYj15lprH0p3fustXI2L3T9I5I
         YHna+OTnotxvjz5db/jCDMP7jgMIVVd3lYMBGKKgdR23ZrggO12XqN/U7FJj8/qBEcBI
         iBQ+XfcCiX7bynoxmDR2EB26SKWs+qSnEAPcfJIpyAorX/eZ8dinAzFigVRTUxPiTnyG
         1FqLWUBdjbJKZKcwYjaKuKwl5WAVRhjhImp3e+8Njqvz9MRv6La6AOCEmFeVzveOcAIp
         dWycYyWW3HLTpCo4J4gy6cqb2V6hvRw3ukIJWZlBi66xlH69ngCiSNngL7QIuY11SdOJ
         OTEg==
X-Gm-Message-State: APjAAAW88o387bBaiXlcwnNdTvCjWdbLsor/GRmIvt3+mljXtsRmPROJ
        +M2tMyLn+ZPJWUUuXnveq71JnnojUso=
X-Google-Smtp-Source: APXvYqyyUaff9xV5SspGMT2JokOmkLiKM0IXP359cQEe38/yhvST+XYtFtBy5Z72J3GInW5pUHEk0g==
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr11972282qvb.117.1581613032367;
        Thu, 13 Feb 2020 08:57:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:94a4])
        by smtp.gmail.com with ESMTPSA id f2sm177161qkm.81.2020.02.13.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:57:11 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:57:11 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213165711.GJ88887@mtj.thefacebook.com>
References: <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213163636.GH31689@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Feb 13, 2020 at 05:36:36PM +0100, Michal Hocko wrote:
> AFAIK systemd already offers knobs to configure resource controls [1].

Yes, it can set up the control knobs as directed but it doesn't ship
with any material resource configurations or has conventions set up
around it.

> Besides that we are talking about memcg features which are available only
> unified hieararchy and that is what systemd is using already.

I'm not quite sure what the above sentence is trying to say.

> > You gotta
> > change the layout to configure resource control no matter what and
> > it's pretty easy to do. systemd folks are planning to integrate higher
> > level resource control features, so my expectation is that the default
> > layout is gonna change as it develops.
> 
> Do you have any pointers to those discussions? I am not really following
> systemd development.

There's a plan to integrate streamlined implementation of oomd into
systemd. There was a thread somewhere but the only thing I can find
now is a phoronix link.

  https://www.phoronix.com/scan.php?page=news_item&px=Systemd-Facebook-OOMD

systemd recently implemented DisableControllers so that upper level
slices can have authority over what controllers are enabled below it
and in a similar vein there were discussions over making it
auto-propagate some of the configs down the hierarchy but kernel doing
the right thing and maintaining consistent semantics across
controllers seems to be the right approach.

There was also a discussion with a distro. Nothing concrete yet but I
think we're more likely to see more resource control configs being
deployed by default in the future.

> Anyway, I am skeptical that systemd can do anything much more clever
> than placing cgroups with a resource control under the root cgroup. At
> least not without some tagging which workloads are somehow related.

Yeah, exactly, all it needs to do is placing scopes / services
according to resource hierarchy and configure overall policy at higher
level slices, which is exactly what the memory.low semantics change
will allow.

> That being said, I do not really blame systemd here. We are not making
> their life particularly easy TBH.

Do you mind elaborating a bit?

Thanks.

-- 
tejun
