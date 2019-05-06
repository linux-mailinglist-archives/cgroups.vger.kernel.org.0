Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6606F14898
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFKxa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 06:53:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36776 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFKxa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 06:53:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id q185so9971925ywe.3;
        Mon, 06 May 2019 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50EG+trP/QNF1/rVOkcJ9cXLlQJhU4E/MXLlGf8zoUI=;
        b=oAHwcPbrBlJUFmA7OrdEUpdC1oduwpy6pefohGXu8XOL5veJiD/QdbOOQnSuVick0I
         QhGlfKe+0z98IHPfc5nT+pcfmQXcnCNn2xE6uoeVLbuwtsIEo06q0vDiOnNOdQgIYMri
         1CuLcvW1/uhvQAKp4cOq9IXL1O6xucoMidX9fllRRmjtJNnS0hadIGX+O382bRRykqn8
         V5Vy+Gq9gdhsdY+P2P3QMXlMz4FYkcNcSC3moWdv0v87bftYetps1su9rGvk+sdqvozt
         Ri7zhfIOGRgtkPl3WRf+CEQpxDllyTRQXVO/uD9l5AuB6tEhFKEvGYLxjgFmrr9ZMXCk
         u1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50EG+trP/QNF1/rVOkcJ9cXLlQJhU4E/MXLlGf8zoUI=;
        b=ATr2UB3Tmya1cBcuOeywuTcyL0Nd8z5LETqeqf43sODXk3dfxlJd0JHREz6jNZAcP/
         n7hlvyZvPncdJhuFvMQnP83GdwYU1dorvwLGg9skjJbBlsPbe23VbowuYdFhv5FEcJJw
         KwMoiUgOmGnkQg1nYsUz7+ekSaFRDljOhLGCO0OFD+jYIRFmjxQJ1au9tXMOs4gP7jYE
         g9GvMI7XM/iVGjVuJ0vgBYj3tVmYpTS4a+KrJx4i2n1duIsDqyq/ixqIxgq2Cw1n1qfL
         4/TkMJ2qLhU5Lry7l4K5b5Vt8obqOmWzE53dgVod/DCWqYX9cfEi+H5O18TyVgYG3ch/
         wRAw==
X-Gm-Message-State: APjAAAX3N1D2ebO09FNhOucRetAr3jjRG5P209OOOZMAFiFi/h6iwiZI
        rFDSz7wV64LgbxcbUdPnHuALHfnRl7QQ7sYel9yP9g==
X-Google-Smtp-Source: APXvYqwHX/mVjNrAwBxWRV8kJ12bSTzrIsJBBOy9EeB5fQ3oLOd5Q5raWNSY0WQi3ueK/Q0uuLuA2q11lItipNrEXQg=
X-Received: by 2002:a25:74c9:: with SMTP id p192mr17553849ybc.507.1557140009215;
 Mon, 06 May 2019 03:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190506074102.87444-1-jiufei.xue@linux.alibaba.com> <CAOQ4uxgptpGyaG5-Wtr8v6SnAvYqXQ-fkmkM0Cjg0jJzij4b8w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgptpGyaG5-Wtr8v6SnAvYqXQ-fkmkM0Cjg0jJzij4b8w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 May 2019 13:53:18 +0300
Message-ID: <CAOQ4uxh2==_TVR0GHgoBf075PhfmhmD7jO+h4YVv4yzdS+Q=Lg@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: check the capability before cred overridden
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 6, 2019 at 1:51 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, May 6, 2019 at 10:41 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
> >
> > We found that it return success when we set IMMUTABLE_FL flag to a
> > file in docker even though the docker didn't have the capability
> > CAP_LINUX_IMMUTABLE.
> >
> > The commit d1d04ef8572b ("ovl: stack file ops") and
> > dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
> > operations on a regular overlay file. ovl_real_ioctl() overridden the
> > current process's subjective credentials with ofs->creator_cred which
> > have the capability CAP_LINUX_IMMUTABLE so that it will return success
> > in vfs_ioctl()->cap_capable().
> >
> > Fix this by checking the capability before cred overriden. And here we
> > only care about APPEND_FL and IMMUTABLE_FL, so get these information from
> > inode.
>
> Good idea. My idea was less good ;-)
> See one minor comment below.
>
> Will you be able to write an xfstest to cover this bug?
> See for reference tests/generic/159 and tests/generic/099
>

To clarify, I mean a generic test that will pass on non-overlayfs
and fail when xfstests are run with check -overlay without your fix.

Thanks,
Amir.
