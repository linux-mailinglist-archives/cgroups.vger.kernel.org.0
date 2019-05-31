Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E874313FD
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2019 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaRkc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 May 2019 13:40:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46882 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRkb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 May 2019 13:40:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so1813987qtz.13
        for <cgroups@vger.kernel.org>; Fri, 31 May 2019 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5NH62ZbHOgoMY3JU5ToOGbndce1BwOUJ3y5aWS4FGc=;
        b=LFOj65SSNi4fohq41TDU8jLLWmQcNtcreYHLmMfQhXbiPpmL53SsjyGgFdHig+C61+
         yZCpes8R8kAp3rnBsXsgm+Ib362mxHmErkF/9YBJz/icbwp6X5Osmm3tovvnI7qGTEl5
         EC8jQhUIlO9AbRy3WieHZzCa6pO41i3Lwy/5GWqoL+bH6Fq1O5AM3PCnUxGqq3ZJA+67
         cLpZc4jaFBmKDHg8VsQvfy779h28s2Vf6w2wR3B0u79lrwAAFHW88WpgvtBCrsgs5CIB
         eyKw3NZZfyGD8Fooo+Se+wFLnnUJIw45elGhSCQ8PpucsYj/W7ezO7fe29l3jH5TO29U
         ToHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5NH62ZbHOgoMY3JU5ToOGbndce1BwOUJ3y5aWS4FGc=;
        b=iawzEezYiIG7EQbNhkk0K3Ot/Orne3ijBgMESFPESiYo2uWjxQyo5EYalj7nXax8Cs
         jrmyKcO9l3S/uDCej9LKSBFb2VtF+TWnO9s4NeE76zDVfUXnlN/kr23o384DFp/Gq5kD
         8HTMGH0/Z4wFOj47fHWcdDFzAr1hljPL2EGAg9WFVZRLVobni6jnZKHddKSK9qX/jNtE
         PdAubzdkEFJLRFFNj/U66jNTM/WT2hGEpuoCbJVsyTbNk1TviPsFJwlqiqdoSzaAS3y+
         EDQd8FjkNWMRuwrKo3vrS+MwgbSlX986l6tUOoKXoewG70jTqIt7CfwyOdh0wLxVgo3P
         pW/A==
X-Gm-Message-State: APjAAAV3NaX0QFOkvE4MFI9GpR17SU9UzcDNrPgmABiUyY1fRfp5yKmj
        mjz6OGXrWqnM20uucd49zLQ=
X-Google-Smtp-Source: APXvYqxAq4sW9QeSGPBPX6cAt8VIPnSfkRYHnZBPscB4YKI4paRptI07Z3lIqTIxMpbyHRIfCg92MA==
X-Received: by 2002:ac8:2f7b:: with SMTP id k56mr1041053qta.376.1559324430910;
        Fri, 31 May 2019 10:40:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4513])
        by smtp.gmail.com with ESMTPSA id d16sm4420380qtd.73.2019.05.31.10.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 10:40:29 -0700 (PDT)
Date:   Fri, 31 May 2019 10:40:28 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
Message-ID: <20190531174028.GG374014@devbig004.ftw2.facebook.com>
References: <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190530183845.GU374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530183845.GU374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 30, 2019 at 11:38:45AM -0700, Tejun Heo wrote:
> Hello,
> 
> If there are no objections, I'll apply them to cgroup/for-5.2-fixes in
> a couple days.  Tagging them -stable makes sense but the changes are a
> bit tricky so I wanna wait a bit before doing that.

Applied to cgroup/for-5.2-fixes.

Thanks.

-- 
tejun
