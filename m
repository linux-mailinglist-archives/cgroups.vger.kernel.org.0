Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6182A2F3
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2019 07:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfEYFEK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 May 2019 01:04:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34963 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfEYFEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 May 2019 01:04:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id c17so8567314lfi.2;
        Fri, 24 May 2019 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLuXqw8M7m/MzY2X3gY6zpBBVeaivSJFrrSDxtyUN9Y=;
        b=qxft7CIP/kObu19i+C2b25QKGiEszRgI83UhB7x3Q9qWrgYELV4tgT1qxaODn2iNEo
         HJBkWFKkVUzdRi7RcwucCGsJsa5msSTOvNMQr/uftP969eFaSNUVBhbxC47TV8HtA406
         LRS4tuIWiVEnXz1FzVSj6pEkNkeHWoV+VF+pn8jIHeAhXx3VMe3Br+6f9S5xEISgLqhW
         jtayGie8YBR2AcfgVIeBayxstDuQvgQuaPoWiAUVjj9xX9COTE6p/9kaJ0uJB+419Ei9
         RWoGsqjKC9/5j+/AcIvE/lKvFDm4qdpJL5lSQozo+oWU0RaS7E0xR0ChjINXfMVhh6wz
         AepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLuXqw8M7m/MzY2X3gY6zpBBVeaivSJFrrSDxtyUN9Y=;
        b=bsbb9lHasAvxm9o5kFgKJfaZ+lPHzWfLk05+qHYeJOHWRTuOkX8uQg32viZisA6YlE
         AHJbbTNmgd4Nzw0/Inw3e7d3Njrvhn2TLW64Km5DDynzmVMEhZvUxjuQkyb47V/9aNc4
         Pw/5GMi8DAg0t9jRQBu+s3g1b/4XpKazqr3zc+69hKh0SF2BThG/gzjJFE6tYL+G6wAS
         Dp11sO/PGPV+8g/NAN3I8xOK5pK8j+W1WC56kcca1cHppi6dhT3EEN/thPLa0xRsZWU5
         AYehSf4gxKLoMkF+n0KEMguw2u8BUOJjZ/PVi66fyEOe0vfpnUW2AM0Us9FCww1vIvEF
         DsUg==
X-Gm-Message-State: APjAAAW5t16sq5Nl5ZVhdar3oHRoGr5xO0ViWvLD1hXQKXY3RUtRWQeL
        UBAhqfRrQGtaP9bJN5/6nGdVypFtrwdkrqMePUI=
X-Google-Smtp-Source: APXvYqxx89GxZR03N1HALuZGhhP3i/ERzN5NlHMdIGyBk1OLPEN/DeKgcNY/ksXecN/Nm3ijPQzyCZPQT5Oj0jH73Qg=
X-Received: by 2002:a19:4c55:: with SMTP id z82mr45052947lfa.68.1558760648319;
 Fri, 24 May 2019 22:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190523064412.31498-1-xxhdx1985126@gmail.com> <20190524214855.GJ374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190524214855.GJ374014@devbig004.ftw2.facebook.com>
From:   Xuehan Xu <xxhdx1985126@gmail.com>
Date:   Sat, 25 May 2019 13:03:56 +0800
Message-ID: <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
Subject: Re: [PATCH] cgroup: add a new group controller for cephfs
To:     Tejun Heo <tj@kernel.org>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>,
        "Yan, Zheng" <ukernel@gmail.com>, cgroups@vger.kernel.org,
        Xuehan Xu <xuxuehan@360.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 25 May 2019 at 05:48, Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, May 23, 2019 at 06:44:12AM +0000, xxhdx1985126@gmail.com wrote:
> > From: Xuehan Xu <xuxuehan@360.cn>
> >
> > this controller is supposed to facilitate limiting
> > the metadata ops or data ops issued to the underlying
> > cluster.
>
> Replied on the other post but I'm having a hard time seeing why this
> is necessary.  Please explain in detail.

Hi, Tejun, thanks for your review:)

The reason that we implemented a ceph-specific controller is as follows:
       We have a need to limit our docker instances' rate of io issued
to the underlying Cephfs cluster. As the limitation has to be in the
granularity of docker instance, we think maybe we can leverage the
cgroup interface. At the time, we thought no existing cgroup
controller can satisfy our requirement, as we thought the blkio
controller, the only io related controller, is dedicated to restrain
the io issued to block devices. So we implemented a new controller.

However, Ilya Dryomov pointed out, in another thread in the mailing
list ceph-devel, that the blkio controller is supposed to handle any
io now. We now think maybe we should try to leverage the blkio
controller to implement the cephfs io limiting mechanism. Am I right
about this? Thanks:-)
>
> Thanks.
>
> --
> tejun
